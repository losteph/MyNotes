class Node:
    def __init__(self, state, action, parent, cost, depth):
        self.state = state
        self.action = action
        self.parent = parent
        self.cost = cost
        self.depth = depth

    def expand(self, problem):
        successor = []
        for state, action in problem.successor(self.state):
            successor += [Node(state, action, self, self.cost + problem.cost(self.state, action), self.depth+1)]
        return successor
    
    def solution(self):
        path = []
        node = self

        while node.parent is not None:
            path.append(node.action)
            node = node.parent
        return path[::-1]
