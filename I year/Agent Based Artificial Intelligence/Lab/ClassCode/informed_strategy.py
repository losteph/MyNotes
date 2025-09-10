class GreedySearch:
    def __init__(self, problem):
        self.problem = problem

    def select(self, fringe):
        fringe = sorted(fringe, key=lambda n: self.problem.heuristic(n.state))
        return fringe, fringe.pop(0)


class AStarSearch:
    def __init__(self, problem):
        self.problem = problem

    def select(self, fringe):
        fringe = sorted(fringe, key=lambda n: n.cost + self.problem.heuristic(n.state))
        return fringe, fringe.pop(0)
