import random


class GridGame:
    def __init__(self, N, depth):
        self.N = N
        self.max_depth = depth
        self.initial_state = {
            "max_pos": (0, 0),
            "min_pos": (N-1, N-1),
            "special": self._generate_special_cells(),
            "visited": set(),
            "points": 0
        }

    def _generate_special_cells(self):
        total_special = (self.N * self.N) // 4
        all_cells = [(i, j) for i in range(self.N) for j in range(self.N)]
        all_cells.remove((0, 0))
        all_cells.remove((self.N-1, self.N-1))
        return set(random.sample(all_cells, total_special))

    def actions(self, state, player):
        (x, y) = state["max_pos"] if player == "MAX" else state["min_pos"]
        moves = []
        for dx, dy in [(-1,0), (1,0), (0,-1), (0,1)]:
            nx, ny = x + dx, y + dy
            if 0 <= nx < self.N and 0 <= ny < self.N:
                moves.append((nx, ny))
        return moves

    def result(self, state, player, action):
        new_state = {
            "max_pos": state["max_pos"],
            "min_pos": state["min_pos"],
            "special": state["special"].copy(),
            "visited": state["visited"].copy(),
            "points": state["points"]
        }
        if player == "MAX":
            new_state["max_pos"] = action
            if action in new_state["special"] and action not in new_state["visited"]:
                new_state["visited"].add(action)
                new_state["points"] += 1
        else:
            new_state["min_pos"] = action
        return new_state

    def terminal_test(self, state):
        if state["max_pos"] == state["min_pos"]:
            return True
        if state["points"] == (self.N * self.N) // 4:
            return True
        return False

    def utility(self, state):
        (x1, y1) = state["max_pos"]
        (x2, y2) = state["min_pos"]
        return abs(x1 - x2) + abs(y1 - y2)  # Manhattan distance

    def cut_off_test(self, state, depth):
        return self.terminal_test(state) or depth == self.max_depth









class GridGame2:
    def __init__(self, N):
        self.N = N
        self.initial_state = {
            "max_pos": (0, 0),
            "min_pos": (N-1, N-1),
            "special": self._generate_special_cells(),
            "visited": set(),
            "points": 0
        }

    def _generate_special_cells(self):
        # scegli casualmente N*N/4 celle speciali
        total_special = (self.N * self.N) // 4
        all_cells = [(i, j) for i in range(self.N) for j in range(self.N)]
        all_cells.remove((0, 0))
        all_cells.remove((self.N-1, self.N-1))
        return set(random.sample(all_cells, total_special))

    def actions(self, state, player):
        (x, y) = state["max_pos"] if player == "MAX" else state["min_pos"]
        moves = []
        for dx, dy in [(-1,0), (1,0), (0,-1), (0,1)]:
            nx, ny = x + dx, y + dy
            if 0 <= nx < self.N and 0 <= ny < self.N:
                moves.append((nx, ny))
        return moves

    def result(self, state, player, action):
        new_state = {
            "max_pos": state["max_pos"],
            "min_pos": state["min_pos"],
            "special": state["special"].copy(),
            "visited": state["visited"].copy(),
            "points": state["points"]
        }
        if player == "MAX":
            new_state["max_pos"] = action
            if action in new_state["special"] and action not in new_state["visited"]:
                new_state["visited"].add(action)
                new_state["points"] += 1
        else:
            new_state["min_pos"] = action
        return new_state

    def terminal_test(self, state):
        # fine gioco se MAX catturato o tutti special visitati
        if state["max_pos"] == state["min_pos"]:
            return True
        if state["points"] == (self.N * self.N) // 4:
            return True
        return False

    def utility(self, state):
        # distanza come funzione di utilità (Manhattan)
        (x1, y1) = state["max_pos"]
        (x2, y2) = state["min_pos"]
        return abs(x1 - x2) + abs(y1 - y2)
