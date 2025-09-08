import numpy as np
import math


class AlphaBeta:
    def __init__(self, game):
        self.game = game

    def run(self, state):
        best_score = -math.inf
        best_action = None
        alpha, beta = -math.inf, math.inf

        for action in self.game.actions(state, "MAX"):
            new_state = self.game.result(state, "MAX", action)
            score = self._min_value(new_state, 1, alpha, beta)
            if score > best_score:
                best_score = score
                best_action = action
            alpha = max(alpha, best_score)

        return best_action

    def _max_value(self, state, depth, alpha, beta):
        if self.game.cut_off_test(state, depth):
            return self.game.utility(state)
        v = -math.inf
        for action in self.game.actions(state, "MAX"):
            new_state = self.game.result(state, "MAX", action)
            v = max(v, self._min_value(new_state, depth+1, alpha, beta))
            if v >= beta:
                return v
            alpha = max(alpha, v)
        return v

    def _min_value(self, state, depth, alpha, beta):
        if self.game.cut_off_test(state, depth):
            return self.game.utility(state)
        v = math.inf
        for action in self.game.actions(state, "MIN"):
            new_state = self.game.result(state, "MIN", action)
            v = min(v, self._max_value(new_state, depth+1, alpha, beta))
            if v <= alpha:
                return v
            beta = min(beta, v)
        return v




class AlphaBeta0:
    def __init__(self, game):
        self.game = game

    def alphabetaDecision(self, state):
        return max(self.game.actions(state),
                   key=lambda a: self.minValue(self.game.result(state, a), -np.inf, np.inf))
    
    def minValue(self, state, alpha, beta): 
        if self.game.terminal_test(state):
            return self.game.utility(state)
        
        v = np.inf

        for s, a in self.game.successors(state):
            v = min(v, self.maxValue(s, alpha, beta))
            if v <= alpha:
                return v
            beta = min(v, beta)

        return v
    
    def maxValue(self, state, alpha, beta):
        if self.game.terminal_test(state):
            return self.game.utility(state)
        
        v = -np.inf

        for s, a in self.game.successors(state):
            v = max(v, self.minValue(s, alpha, beta))
            if v >= beta:
                return v
            beta = max(v, alpha)

        return v
    
    def run(self):
        moves = []
        state = self.game.initial_state

        while True:
            if self.game.terminal_test(state):
                return moves
            
            action = self.alphabetaDecision(state)
            state = self.game.result(state, action)
            moves.append((self.game.player, action))
            self.game.next_player()