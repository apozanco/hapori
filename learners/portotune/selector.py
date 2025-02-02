import logging

import numpy as np

import config_selector
from portfolio import Portfolio


class SelectorPortfolio(Portfolio):
    def __init__(self, track,  subset_size, **kwargs):
        """*subset_size* can be a number or "auto"."""
        Portfolio.__init__(self, track, **kwargs)
        self.subset_size = subset_size

    def compute_portfolio(self):
        """Implementation of compute_portfolio method as it is implemented in
        IncreasingTimeslotPortfolio.
        """
        if self.subset_size == "auto":
            score, subset = self.auto_configs_score()
            self.settings.append('Subset size: "auto" (best: %i)' % len(subset))
        elif str(self.subset_size).isdigit():
            subset_size = int(self.subset_size)
            score, subset = self.select_configs_score(subset_size)
            self.settings.append("Subset size: %i" % subset_size)
        else:
            raise ValueError('subset_size can only be a number or "auto"')
        self.schedule_config_ids = np.array(subset)
        # uniform schedule
        self.schedule_runtimes = np.array(
            [self.plantime / len(subset)] * len(subset)
        )

    def auto_configs_score(self):
        """Tries all possible subset sizes and returns the subset for
        the best one.
        """

        def configs_iter():
            for subset_size in self._auto_subset_sizes():
                logging.info("calculating subsets for subset size %d" % subset_size)
                yield self.select_configs_score(subset_size)

        return max(configs_iter(), key=lambda candidate: candidate[0])

    def _auto_subset_sizes(self):
        """Return iterable over all posible subset sizes."""
        return list(range(1, self.runtimes.shape[1]))

    def filter_unsolved_problems(self, times, plantime_single):
        """Returns times as numpy array with all missing values or
        values larger than  plantime single set to a value larger than
        max(time) * num_configs.
        This effectively punishes not solving a problem, giving it more weight
        than anything else in the optimization.
        """
        max_time = np.where(times == None, 0, times).max()
        unsolved_value = max_time * times.shape[0] + 1
        # filter unsolved problems
        times = np.where(times == None, unsolved_value, times)
        # filter times according to the uniform plan time for each config
        return np.where(times > plantime_single, unsolved_value, times)

    def select_configs_score(self, subset_size):
        """Chooses a subset of size subset_size  that maximizes score as
        described in config_selector.max_subset. Problems that would not be
        solved in plantime_single will be treated as unsolved.
        Returns a tuple (accumulated score, subset indices).
        """
        plantime_single = self.plantime / subset_size
        times = self.filter_unsolved_problems(self.runtimes, plantime_single)
        # filter scores of problems that haven't been solved within time
        scores = np.where(times > plantime_single, 0, self.scores)
        logging.info("Calculating subset of configurations.")
        return config_selector.max_subset(scores, subset_size)


class UniformPortfolio(SelectorPortfolio):
    def __init__(self, track, **kwargs):
        SelectorPortfolio.__init__(self, track, subset_size=None, **kwargs)

    def compute_portfolio(self):
        self.subset_size = len(self.algorithms)
        SelectorPortfolio.compute_portfolio(self)
