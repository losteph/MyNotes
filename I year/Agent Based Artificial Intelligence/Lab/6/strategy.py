class BreadthFirst:
    def select(self, fringe):
        return fringe, fringe.pop(0)
    
class DepthFirst:
    def select(self, fringe):
        return fringe, fringe.pop()
    

class Astar:
    def __init__(self, problem):
        self.problem = problem

    def select(self, fringe):
        fringe = sorted(fringe, key=lambda n: self.problem.heuristic(n.state) + n.cost)
        return fringe, fringe.pop(0)
