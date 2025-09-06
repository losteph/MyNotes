class DepthFirstSearch:
    def select(self, fringe):
        return fringe, fringe.pop()


class AStarSearch:
    def __init__(self, problem):
        self.problem = problem
    
    def select(self, fringe):
        fringe = sorted(fringe, key=lambda n: n.cost + self.problem.heuristic(n.state))
        return fringe, fringe.pop(0)
    
