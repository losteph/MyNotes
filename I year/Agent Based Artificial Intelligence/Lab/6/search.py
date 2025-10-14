from node import Node

class Graph:
    def __init__(self, problem, strategy):
        self.problem = problem
        self.strategy = strategy
        self.fringe = []
        self.closed = []

    def run(self):
        self.fringe.append(Node(state=self.problem.initial_state, cost=0, depth=0, parent=None, action=None))
        while True:
            if len(self.fringe) == 0:
                return "fail", []
            self.fringe, node = self.strategy.select(self.fringe)
            if not node:
                return "fail", []
            if self.problem.goal_test(node.state):
                return "success", node.solution()
            
            if node.state not in self.closed:
                self.closed += [node.state]
                fringe_states = [n.state for n in self.fringe]
                self.fringe += [new_node for new_node in node.expand(self.problem) if new_node.state not in fringe_states] 