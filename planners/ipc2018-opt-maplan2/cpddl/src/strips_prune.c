/***
 * cpddl
 * -------
 * Copyright (c)2017 Daniel Fiser <danfis@danfis.cz>,
 * AI Center, Department of Computer Science,
 * Faculty of Electrical Engineering, Czech Technical University in Prague.
 * All rights reserved.
 *
 * This file is part of cpddl.
 *
 * Distributed under the OSI-approved BSD License (the "License");
 * see accompanying file BDS-LICENSE for details or see
 * <http://www.opensource.org/licenses/bsd-license.php>.
 *
 * This software is distributed WITHOUT ANY WARRANTY; without even the
 * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the License for more information.
 */

#include <boruvka/timer.h>
#include "pddl/strips.h"
#include "pddl/mgroup.h"
#include "pddl/mutex.h"
#include "err.h"
#include "assert.h"
#include "profile.h"

/** Prunes irrelevant facts and operators.
 *  Implemented in strips_irrelevance.c */
int _pddlStripsPruneIrrelevant(pddl_strips_t *strips,
                               const pddl_strips_prune_config_t *cfg);


struct prune;

/** Should return:
 *      1  - for successful pruning
 *      0  - for successful run without pruning
 *      -1 - error
 *      -2 - abort due to time limit
 */
typedef int (*prune_alg_fn)(struct prune *prune);

struct alg {
    prune_alg_fn fn;
    int run; /*!< True if this algorithm should be run */
};
typedef struct alg alg_t;

struct prune {
    const pddl_strips_prune_config_t *cfg;
    pddl_strips_t *strips;

    alg_t alg[5];
    int alg_size;

    int *op; /*!< Pre-allocated array for operators */
    bor_timer_t timer;
    float time_elapsed;
    float time_remain;
};
typedef struct prune prune_t;

static int pruneOpArr(prune_t *prune)
{
    int change = 0;

    for (int i = 0; i < prune->strips->op.op_size; ++i){
        if (prune->op[i]){
            change = 1;
            break;
        }
    }

    if (change)
        pddlStripsOpsDelOps(&prune->strips->op, prune->op);
    return change;
}

static int pruneIrrelevance(prune_t *prune)
{
    int ret;

    ret = _pddlStripsPruneIrrelevant(prune->strips, prune->cfg);
    if (ret > 0)
        ret = 1;
    return ret;
}

static int hmutex(prune_t *prune,
                  pddl_strips_t *strips,
                  pddl_mutexes_t *mutex,
                  const char *t)
{
    int ret;

    ret = pddlMutexesHm(mutex, prune->cfg->h_mutex, strips, prune->op,
                        prune->cfg->max_mem, prune->time_remain);

    if (ret == 0){
        if (pruneOpArr(prune))
            ret = 1;
        INFO("O: %d, F: %d :: %s h^%d mutexes (mutexes: %d, change: %d).",
             prune->strips->op.op_size, prune->strips->fact.fact_size, t,
             prune->cfg->h_mutex, prune->strips->mutex.mutex_size, ret);
    }

    return ret;
}

static int pruneHMutex(prune_t *prune)
{
    pddl_strips_t *strips = prune->strips;
    pddl_mutexes_t *mutex = &strips->mutex;
    pddl_strips_t *bw_strips;
    int change = 0, fw = 1, bw = 1;

    pddlMutexesFree(mutex);
    pddlMutexesInit(mutex);

    while ((fw || bw) && !strips->goal_is_unreachable){
        bzero(prune->op, sizeof(int) * strips->op.op_size);
        if (fw){
            fw = 0;
            if (hmutex(prune, strips, mutex, "fw")){
                bw = 1;
                change = 1;
            }

        }else if (bw){
            bw = 0;
            bw_strips = pddlStripsBackward(strips, mutex);
            if (hmutex(prune, bw_strips, mutex, "bw")){
                change = 1;
                fw = 1;
            }
            pddlStripsDel(bw_strips);
        }
        change |= pddlStripsDisambiguate(strips, mutex, &strips->mgroup);
    }

    return change;
}

static int pruneH3(prune_t *prune)
{
    // FIXME: This is whole function is hack for IPC-2018
    static int use = 1;
    pddl_strips_t *strips = prune->strips;
    pddl_mutexes_t *mutex = &strips->mutex;
    float max_time = 60;
    int ret = 0;

    if (!use)
        return 0;

    bzero(prune->op, sizeof(int) * strips->op.op_size);
    ret = pddlMutexesHm(mutex, 3, strips, prune->op,
                        prune->cfg->max_mem, max_time);

    if (ret == 0){
        if (pruneOpArr(prune)){
            ret = 1;
        }
        INFO("O: %d, F: %d :: fw h^3 mutexes (mutexes: %d, change: %d).",
             strips->op.op_size, strips->fact.fact_size,
             strips->mutex.mutex_size, ret);
        if (ret == 1)
            pddlStripsDisambiguate(strips, mutex, &strips->mgroup);
    }else{
        INFO("O: %d, F: %d :: fw h^3 mutexes timeout.",
             strips->op.op_size, strips->fact.fact_size);
        ret = 0;
        use = 0;
    }

    if (!use)
        return ret;

    bzero(prune->op, sizeof(int) * strips->op.op_size);
    pddl_strips_t *bw_strips = pddlStripsBackward(strips, mutex);
    ret = pddlMutexesHm(mutex, 3, bw_strips, prune->op,
            prune->cfg->max_mem, max_time);
    pddlStripsDel(bw_strips);
    if (ret == 0){
        if (pruneOpArr(prune)){
            ret = 1;
        }
        INFO("O: %d, F: %d :: bw h^3 mutexes (mutexes: %d, change: %d).",
                strips->op.op_size, strips->fact.fact_size,
                strips->mutex.mutex_size, ret);
        if (ret == 1)
            pddlStripsDisambiguate(strips, mutex, &strips->mgroup);
    }else{
        INFO("O: %d, F: %d :: bw h^3 mutexes timeout.",
                strips->op.op_size, strips->fact.fact_size);
        ret = 0;
        use = 0;
    }

    return ret;
}

static int pruneH3Bw(prune_t *prune)
{
    pddl_strips_t *strips = prune->strips;
    pddl_mutexes_t *mutex = &strips->mutex;
    int ret;

    bzero(prune->op, sizeof(int) * strips->op.op_size);
    ret = pddlMutexesHm(mutex, 3, strips, prune->op,
                        prune->cfg->max_mem, 120);

    if (ret == 0){
        if (pruneOpArr(prune)){
            ret = 1;
            pddlStripsDisambiguate(strips, mutex, &strips->mgroup);
        }
        INFO("O: %d, F: %d :: hw h^3 mutexes (mutexes: %d, change: %d).",
             strips->op.op_size, strips->fact.fact_size,
             strips->mutex.mutex_size, ret);
    }else{
        INFO("O: %d, F: %d :: hw h^3 mutexes timeout.",
             strips->op.op_size, strips->fact.fact_size);
        ret = 0;
    }

    return ret;
}

static int pruneOpWithMGroup(const pddl_mgroup_t *mg,
                             const bor_iset_t *mpre,
                             const bor_iset_t *mdel,
                             const bor_iset_t *mpredel,
                             const bor_iset_t *madd,
                             const pddl_strips_prune_config_t *cfg)
{
    // If the precondition or add effect contains more one fact
    // from the mutex group, it is clearly an unreachable operator
    if (borISetSize(mpre) > 1 || borISetSize(madd) > 1)
        return 1;

    // The dead-end operators are those that delete all fact from
    // the fact-alternating mutex group even though it is required
    // that one of the facts is part of the goal.
    if (cfg->fa_mgroup_dead_end
            && mg->is_fa
            && mg->is_goal
            && borISetSize(madd) == 0
            && borISetSize(mpredel) > 0){
        return 1;
    }

    return 0;
}

static int pruneWithMGroups(pddl_strips_t *strips,
                            const pddl_mgroups_t *mgs,
                            const pddl_strips_prune_config_t *cfg,
                            int *prune_op)
{
    int change = 0;
    const pddl_mgroup_t *mg;
    bor_iset_t mpre, mdel, mpredel, madd;

    // Reuse array for operators
    bzero(prune_op, sizeof(int) * strips->op.op_size);

    borISetInit(&mpre);
    borISetInit(&mdel);
    borISetInit(&mpredel);
    borISetInit(&madd);

    PDDL_MGROUPS_FOR_EACH(mgs, mg){
        for (int opi = 0; opi < strips->op.op_size; ++opi){
            pddl_strips_op_t *op = strips->op.op[opi];
            if (op == NULL || prune_op[opi])
                continue;

            borISetIntersect2(&mpre, &mg->fact, &op->pre);
            borISetIntersect2(&mdel, &mg->fact, &op->del_eff);
            borISetIntersect2(&mpredel, &mpre, &mdel);
            borISetIntersect2(&madd, &mg->fact, &op->add_eff);

            prune_op[opi] = pruneOpWithMGroup(mg, &mpre, &mdel, &mpredel,
                                              &madd, cfg);
            change |= prune_op[opi];

            // Disambiguate delete effect
            if (cfg->disambiguation
                    && borISetSize(&mpre) > 0
                    && borISetSize(&mdel) > 0
                    && borISetSize(&mpredel) != borISetSize(&mdel)){
                WARN("Disambiguation of delete effect of %s", op->name);
                borISetMinus(&mdel, &mpredel);
                borISetMinus(&op->del_eff, &mdel);
            }
        }
    }

    pddlStripsOpsDelOps(&strips->op, prune_op);

    borISetFree(&mpre);
    borISetFree(&mdel);
    borISetFree(&mpredel);
    borISetFree(&madd);

    return change;
}

static int pruneFAMGroup(prune_t *prune)
{
    pddl_strips_t *strips = prune->strips;
    pddl_mgroups_t *mgroup = &strips->mgroup;
    int ret;

    pddlMGroupsFree(mgroup);
    pddlMGroupsInit(mgroup);
    ret = pddlMGroupsFA(strips, mgroup);

    if (ret == 0){
        if (pruneWithMGroups(strips, mgroup, prune->cfg, prune->op))
            ret = 1;

        // TODO: Count dead-end operators
        INFO("O: %d, F: %d :: fam-groups (mgroups: %d, change: %d).",
             strips->op.op_size, strips->fact.fact_size,
             strips->mgroup.mgroup_size, ret);
        pddlMGroupsFinalize(&strips->mgroup, strips);
    }

    return ret;
}

static int pruneDisambiguation(prune_t *prune)
{
    return pddlStripsDisambiguate(prune->strips, NULL, NULL);
}

static void updateTimer(prune_t *prune)
{
    borTimerStop(&prune->timer);
    prune->time_elapsed = borTimerElapsedInSF(&prune->timer);

    if (prune->cfg->max_time <= 0.f){
        prune->time_remain = 1E10;
    }else{
        prune->time_remain = prune->cfg->max_time - prune->time_elapsed;
    }
}

static void enableAlgs(prune_t *prune, int except)
{
    for (int i = 0; i < prune->alg_size; ++i){
        if (i != except)
            prune->alg[i].run = 1;
    }
}

static void disableAllAlgs(prune_t *prune)
{
    for (int i = 0; i < prune->alg_size; ++i)
        prune->alg[i].run = 0;
}

static void checkTimer(prune_t *prune)
{
    updateTimer(prune);

    if (prune->time_remain < 0.f){
        disableAllAlgs(prune);
        INFO("  == Time limit for pruning was exceeded (%f/%f)",
             prune->time_elapsed, prune->cfg->max_time);
    }
}

static int pruneAlg(prune_t *prune, int alg_id)
{
    alg_t *alg = prune->alg + alg_id;
    int ret;

    updateTimer(prune);

    alg->run = 0;
    ret = alg->fn(prune);
    if (ret == 1){
        enableAlgs(prune, alg_id);

    }else if (ret == -1){
        TRACE_RET(-1);

    }else if (ret == -2){
        disableAllAlgs(prune);
    }

    checkTimer(prune);

    return 0;
}

int pddlStripsPrune(pddl_strips_t *strips,
                    const pddl_strips_prune_config_t *cfg)
{
    prune_t prune;
    int cont, ret = 0;

    if (strips->goal_is_unreachable)
        return 0;

    prune.cfg = cfg;
    prune.strips = strips;

    prune.alg_size = 0;
    if (cfg->irrelevance || cfg->static_facts)
        prune.alg[prune.alg_size++].fn = pruneIrrelevance;
    if (cfg->fa_mgroup)
        prune.alg[prune.alg_size++].fn = pruneFAMGroup;
    if (cfg->h_mutex > 0)
        prune.alg[prune.alg_size++].fn = pruneHMutex;
    if (cfg->h_mutex > 0)
        prune.alg[prune.alg_size++].fn = pruneH3;
    //if (cfg->disambiguation && cfg->fa_mgroup)
    //    prune.alg[prune.alg_size++].fn = pruneDisambiguation;

    for (int i = 0; i < prune.alg_size; ++i)
        prune.alg[i].run = 1;

    prune.op = BOR_ALLOC_ARR(int, strips->op.op_size);
    borTimerStart(&prune.timer);
    updateTimer(&prune);

    do {
        cont = 0;
        for (int i = 0; i < prune.alg_size; ++i){
            if (prune.alg[i].run){
                if ((ret = pruneAlg(&prune, i)) != 0){
                    cont = 0;
                    break;
                }
                cont = 1;
            }
        }
    } while (cfg->fixpoint && cont && !strips->goal_is_unreachable);

    if (ret == 0)
        INFO2("The STRIPS problem is pruned.");

    BOR_FREE(prune.op);
    return ret;
}

