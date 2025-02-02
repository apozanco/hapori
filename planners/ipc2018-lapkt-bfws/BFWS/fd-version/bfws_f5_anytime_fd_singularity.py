#! /usr/bin/env python
import fd.grounding
import sys
import os
from libbfws import BFWS
# NIR: Profiler imports
#import yep

ALIASES = {}

DIR_CURR_FILE = os.path.abspath(__file__)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.dirname(DIR_CURR_FILE)))

def main( domain_file, problem_file, output ) :
	task = BFWS( )

        #NIR: Costs are parsed, but the search ignores action costs. If set to True, it will report plan length
        task.ignore_action_costs = False

	fd.grounding.default( domain_file, problem_file, task )

	#NIR: Uncomment to check what actions are being loaded
	#for i in range( 0, task.num_actions() ) :
	#	task.print_action( i )

	# NIR: Setting planner parameters is as easy as setting the values
	# of Python object attributes

	# NIR: log and plan filename set
	task.log_filename = 'bfws.log'
        task.plan_filename = output+".1"

	# NIR: search alg
	task.search = "BFWS-f5"

        # NIR: Set Max novelty to 2
        #task.max_novelty = 2

        # NIR: Set M to 32
        #task.m_value = 32

	# NIR: Comment line below to deactivate profiling
	#yep.start( 'bfws.prof' )

	# NIR: We call the setup method in SIW_Planner
	task.setup()

	# NIR: And then we're ready to go
	task.solve()

	#NIR: Comment lines below to deactivate profile
	#yep.stop()

	#rv = os.system( 'google-pprof --pdf libbfws.so bfws.prof > bfws.pdf' )
	#if rv != 0 :
	#	print >> sys.stderr, "An error occurred while translating google-perftools profiling information into valgrind format"

        #NIR: call FD implementation of Restarting WAstar


        fd_cmd =  os.path.join(BASE_DIR, "Fast-Downward-2018-2/fast-downward-singularity.py") + " --build release64 --alias lazy-rwastar --plan-file {} --external-bound {} {} {}".format(output, int(task.plan_cost),domain_file, problem_file)
        os.system(fd_cmd)

def debug() :
	main( "domain.pddl",
              "p01.pddl",
              "solution" )

if __name__ == "__main__":
	main( sys.argv[1], sys.argv[2], sys.argv[3] )

