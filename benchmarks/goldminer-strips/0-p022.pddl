(define (problem typed-bomberman-rows4-cols11)
(:domain gold-miner-typed)
(:objects 
        f0-0f f0-1f f0-2f f0-3f f0-4f f0-5f f0-6f f0-7f f0-8f f0-9f f0-10f 
        f1-0f f1-1f f1-2f f1-3f f1-4f f1-5f f1-6f f1-7f f1-8f f1-9f f1-10f 
        f2-0f f2-1f f2-2f f2-3f f2-4f f2-5f f2-6f f2-7f f2-8f f2-9f f2-10f 
        f3-0f f3-1f f3-2f f3-3f f3-4f f3-5f f3-6f f3-7f f3-8f f3-9f f3-10f  - LOC
)
(:init
(arm-empty)
(connected f0-0f f0-1f)
(connected f0-1f f0-2f)
(connected f0-2f f0-3f)
(connected f0-3f f0-4f)
(connected f0-4f f0-5f)
(connected f0-5f f0-6f)
(connected f0-6f f0-7f)
(connected f0-7f f0-8f)
(connected f0-8f f0-9f)
(connected f0-9f f0-10f)
(connected f1-0f f1-1f)
(connected f1-1f f1-2f)
(connected f1-2f f1-3f)
(connected f1-3f f1-4f)
(connected f1-4f f1-5f)
(connected f1-5f f1-6f)
(connected f1-6f f1-7f)
(connected f1-7f f1-8f)
(connected f1-8f f1-9f)
(connected f1-9f f1-10f)
(connected f2-0f f2-1f)
(connected f2-1f f2-2f)
(connected f2-2f f2-3f)
(connected f2-3f f2-4f)
(connected f2-4f f2-5f)
(connected f2-5f f2-6f)
(connected f2-6f f2-7f)
(connected f2-7f f2-8f)
(connected f2-8f f2-9f)
(connected f2-9f f2-10f)
(connected f3-0f f3-1f)
(connected f3-1f f3-2f)
(connected f3-2f f3-3f)
(connected f3-3f f3-4f)
(connected f3-4f f3-5f)
(connected f3-5f f3-6f)
(connected f3-6f f3-7f)
(connected f3-7f f3-8f)
(connected f3-8f f3-9f)
(connected f3-9f f3-10f)
(connected f0-0f f1-0f)
(connected f0-1f f1-1f)
(connected f0-2f f1-2f)
(connected f0-3f f1-3f)
(connected f0-4f f1-4f)
(connected f0-5f f1-5f)
(connected f0-6f f1-6f)
(connected f0-7f f1-7f)
(connected f0-8f f1-8f)
(connected f0-9f f1-9f)
(connected f0-10f f1-10f)
(connected f1-0f f2-0f)
(connected f1-1f f2-1f)
(connected f1-2f f2-2f)
(connected f1-3f f2-3f)
(connected f1-4f f2-4f)
(connected f1-5f f2-5f)
(connected f1-6f f2-6f)
(connected f1-7f f2-7f)
(connected f1-8f f2-8f)
(connected f1-9f f2-9f)
(connected f1-10f f2-10f)
(connected f2-0f f3-0f)
(connected f2-1f f3-1f)
(connected f2-2f f3-2f)
(connected f2-3f f3-3f)
(connected f2-4f f3-4f)
(connected f2-5f f3-5f)
(connected f2-6f f3-6f)
(connected f2-7f f3-7f)
(connected f2-8f f3-8f)
(connected f2-9f f3-9f)
(connected f2-10f f3-10f)
(connected f0-1f f0-0f)
(connected f0-2f f0-1f)
(connected f0-3f f0-2f)
(connected f0-4f f0-3f)
(connected f0-5f f0-4f)
(connected f0-6f f0-5f)
(connected f0-7f f0-6f)
(connected f0-8f f0-7f)
(connected f0-9f f0-8f)
(connected f0-10f f0-9f)
(connected f1-1f f1-0f)
(connected f1-2f f1-1f)
(connected f1-3f f1-2f)
(connected f1-4f f1-3f)
(connected f1-5f f1-4f)
(connected f1-6f f1-5f)
(connected f1-7f f1-6f)
(connected f1-8f f1-7f)
(connected f1-9f f1-8f)
(connected f1-10f f1-9f)
(connected f2-1f f2-0f)
(connected f2-2f f2-1f)
(connected f2-3f f2-2f)
(connected f2-4f f2-3f)
(connected f2-5f f2-4f)
(connected f2-6f f2-5f)
(connected f2-7f f2-6f)
(connected f2-8f f2-7f)
(connected f2-9f f2-8f)
(connected f2-10f f2-9f)
(connected f3-1f f3-0f)
(connected f3-2f f3-1f)
(connected f3-3f f3-2f)
(connected f3-4f f3-3f)
(connected f3-5f f3-4f)
(connected f3-6f f3-5f)
(connected f3-7f f3-6f)
(connected f3-8f f3-7f)
(connected f3-9f f3-8f)
(connected f3-10f f3-9f)
(connected f1-0f f0-0f)
(connected f1-1f f0-1f)
(connected f1-2f f0-2f)
(connected f1-3f f0-3f)
(connected f1-4f f0-4f)
(connected f1-5f f0-5f)
(connected f1-6f f0-6f)
(connected f1-7f f0-7f)
(connected f1-8f f0-8f)
(connected f1-9f f0-9f)
(connected f1-10f f0-10f)
(connected f2-0f f1-0f)
(connected f2-1f f1-1f)
(connected f2-2f f1-2f)
(connected f2-3f f1-3f)
(connected f2-4f f1-4f)
(connected f2-5f f1-5f)
(connected f2-6f f1-6f)
(connected f2-7f f1-7f)
(connected f2-8f f1-8f)
(connected f2-9f f1-9f)
(connected f2-10f f1-10f)
(connected f3-0f f2-0f)
(connected f3-1f f2-1f)
(connected f3-2f f2-2f)
(connected f3-3f f2-3f)
(connected f3-4f f2-4f)
(connected f3-5f f2-5f)
(connected f3-6f f2-6f)
(connected f3-7f f2-7f)
(connected f3-8f f2-8f)
(connected f3-9f f2-9f)
(connected f3-10f f2-10f)
(robot-at f0-0f)
(clear f0-0f)
(soft-rock-at f0-1f)
(soft-rock-at f0-2f)
(soft-rock-at f0-3f)
(soft-rock-at f0-4f)
(soft-rock-at f0-5f)
(soft-rock-at f0-6f)
(soft-rock-at f0-7f)
(soft-rock-at f0-8f)
(soft-rock-at f0-9f)
(soft-rock-at f0-10f)
(bomb-at f1-0f)
(laser-at f1-0f)
(clear f1-0f)
(hard-rock-at f1-1f)
(hard-rock-at f1-2f)
(hard-rock-at f1-3f)
(soft-rock-at f1-4f)
(soft-rock-at f1-5f)
(hard-rock-at f1-6f)
(hard-rock-at f1-7f)
(soft-rock-at f1-8f)
(hard-rock-at f1-9f)
(soft-rock-at f1-10f)
(clear f2-0f)
(soft-rock-at f2-1f)
(soft-rock-at f2-2f)
(hard-rock-at f2-3f)
(hard-rock-at f2-4f)
(soft-rock-at f2-5f)
(soft-rock-at f2-6f)
(soft-rock-at f2-7f)
(soft-rock-at f2-8f)
(soft-rock-at f2-9f)
(gold-at f2-10f)
(soft-rock-at f2-10f)
(clear f3-0f)
(soft-rock-at f3-1f)
(soft-rock-at f3-2f)
(hard-rock-at f3-3f)
(hard-rock-at f3-4f)
(hard-rock-at f3-5f)
(soft-rock-at f3-6f)
(soft-rock-at f3-7f)
(soft-rock-at f3-8f)
(hard-rock-at f3-9f)
(soft-rock-at f3-10f)
)
(:goal
(holds-gold)
))
