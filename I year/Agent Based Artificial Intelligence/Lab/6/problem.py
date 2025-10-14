class Problem:
    def __init__(self, initial_state, goal_state, environment):
        self.initial_state = initial_state
        self.goal_state = goal_state
        self.environment = environment
        self.rows = len(environment)
        self.cols = len(environment[0])

    def cost(self, state, action):
        return 1
    
    def goal_test(self, state):
        return self.goal_state == state
    
    def successor(self, state):
        actions = self.actions(state)
        return [(self.result(state, action), action) for action in actions]
    
    def actions(self, state):
        (row, col) = state
        moves = []
        # controlla i limiti della griglia e le celle bloccate
        if row > 0 and self.environment[row-1][col] != "o":
            moves.append("Up")
        if row < self.rows-1 and self.environment[row+1][col] != "o":
            moves.append("Down")
        if col > 0 and self.environment[row][col-1] != "o":
            moves.append("Left")
        if col < self.cols-1 and self.environment[row][col+1] != "o":
            moves.append("Right")
        return moves

    def result(self, state, action):
        (row, col) = state
        if action == "Up":
            new_state = (row - 1, col)
        elif action == "Down":
            new_state = (row + 1, col)
        elif action == "Left":
            new_state = (row, col - 1)
        elif action == "Right":
            new_state = (row, col + 1)
        else:
            new_state = state  # sicurezza
        return new_state

    def heuristic(self, state):
        # Manhattan distance
        (i1, j1) = state
        (i2, j2) = self.goal_state
        return abs(i1 - i2) + abs(j1 - j2)