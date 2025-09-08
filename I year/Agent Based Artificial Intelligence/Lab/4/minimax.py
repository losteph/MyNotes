import math


class Minimax:
    def __init__(self, game):
        self.game = game

    def run(self, state):
        best_score, best_action = self.max_value(state, 0)
        return best_action

    def max_value(self, state, depth):
        if self.game.cut_off_test(state, depth):
            return self.game.utility(state), None
        value = -math.inf
        best_action = None
        for action in self.game.actions(state, "MAX"):
            new_state = self.game.result(state, "MAX", action)
            score, _ = self.min_value(new_state, depth+1)
            if score > value:
                value, best_action = score, action
        return value, best_action

    def min_value(self, state, depth):
        if self.game.cut_off_test(state, depth):
            return self.game.utility(state), None
        value = math.inf
        best_action = None
        for action in self.game.actions(state, "MIN"):
            new_state = self.game.result(state, "MIN", action)
            score, _ = self.max_value(new_state, depth+1)
            if score < value:
                value, best_action = score, action
        return value, best_action






class Minimax2:
    def __init__(self, game, depth=10):
        self.game = game
        self.max_depth = depth

    def run(self, state):
        best_score, best_action = self.max_value(state, 0)
        return best_action

    def max_value(self, state, depth):
        if self.game.terminal_test(state) or depth == self.max_depth:
            return self.game.utility(state), None
        value = -math.inf
        best_action = None
        for action in self.game.actions(state, "MAX"):
            new_state = self.game.result(state, "MAX", action)
            score, _ = self.min_value(new_state, depth+1)
            if score > value:
                value, best_action = score, action
        return value, best_action

    def min_value(self, state, depth):
        if self.game.terminal_test(state) or depth == self.max_depth:
            return self.game.utility(state), None
        value = math.inf
        best_action = None
        for action in self.game.actions(state, "MIN"):
            new_state = self.game.result(state, "MIN", action)
            score, _ = self.max_value(new_state, depth+1)
            if score < value:
                value, best_action = score, action
        return value, best_action
