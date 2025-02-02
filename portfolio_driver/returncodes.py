import sys

"""
We document Fast Downward exit codes at
https://www.fast-downward.org/ExitCodes. Please update this documentation when
making changes below.
"""

### return codes of this driver
PORTFOLIO_SUCCESS = 0
PORTFOLIO_OUT_OF_MEMORY = 122
PORTFOLIO_OUT_OF_TIME = 123
PORTFOLIO_OUT_OF_MEMORY_AND_TIME = 124
PORTFOLIO_ERROR = 125
PORTFOLIO_ERROR_AND_OUT_OF_MEMORY = 126
PORTFOLIO_ERROR_AND_OUT_OF_TIME = 127
PORTFOLIO_ERROR_AND_OUT_OF_MEMORY_AND_TIME = 128
DRIVER_CRITICAL_ERROR = 135
DRIVER_INPUT_ERROR = 136
DRIVER_UNSUPPORTED = 137

### runlim return codes -- returned from each component planner call
SUCCESS = 0
EXECVP_FAILED = 1
OUT_OF_TIME = 2
OUT_OF_MEMORY = 3
SEGFAULT = 4
BUS_ERROR = 5
FORK_FAILED = 6
INTERNAL_ERROR = 7
SOME_SIGNAL = 11
### runlim propagates run.py return codes if not aborting/crashing
HAPORI_UNKNOWN = 99


def print_stderr(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def exit_with_driver_critical_error(msg):
    print_stderr(msg)
    sys.exit(DRIVER_CRITICAL_ERROR)


def exit_with_driver_input_error(msg):
    print_stderr(msg)
    sys.exit(DRIVER_INPUT_ERROR)


def exit_with_driver_unsupported_error(msg):
    print_stderr(msg)
    sys.exit(DRIVER_UNSUPPORTED)


def generate_portfolio_exitcode(exitcodes):
    print("Exit codes: {}".format(exitcodes))
    exitcodes = set(exitcodes)

    if not exitcodes:
        return PORTFOLIO_ERROR

    # At least one plan was found.
    if SUCCESS in exitcodes:
        return PORTFOLIO_SUCCESS

    # All component planners failed.
    if all(res in [
        EXECVP_FAILED, SEGFAULT, BUS_ERROR, FORK_FAILED, INTERNAL_ERROR, SOME_SIGNAL, HAPORI_UNKNOWN
        ] for res in exitcodes):
        return PORTFOLIO_ERROR

    # Some component planners failed.
    error = False
    if any(res in [
        EXECVP_FAILED, SEGFAULT, BUS_ERROR, FORK_FAILED, INTERNAL_ERROR, SOME_SIGNAL, HAPORI_UNKNOWN
        ] for res in exitcodes):
        error = True

    # No plan was found due to hitting resource limits.
    if OUT_OF_MEMORY in exitcodes and OUT_OF_TIME in exitcodes:
        if error:
            return PORTFOLIO_ERROR_AND_OUT_OF_MEMORY_AND_TIME
        return PORTFOLIO_OUT_OF_MEMORY_AND_TIME
    elif OUT_OF_MEMORY in exitcodes:
        if error:
            return PORTFOLIO_ERROR_AND_OUT_OF_MEMORY
        return PORTFOLIO_OUT_OF_MEMORY
    elif OUT_OF_TIME in exitcodes:
        if error:
            return PORTFOLIO_ERROR_AND_OUT_OF_TIME
        return PORTFOLIO_OUT_OF_TIME

    assert False, "Error: Unhandled exit codes: {}".format(exitcodes)
