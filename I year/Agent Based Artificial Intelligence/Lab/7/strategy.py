class AStarSearch:
    
    def __init__(self, problem):
        self.problem = problem

    def select(self, fringe):
        """
        Seleziona il nodo con il valore f(n) = g(n) + h(n) minore.
        """
        # Ordina la frontiera (fringe) in base a f(n)
        # g(n) = n.cost
        # h(n) = self.problem.heuristic(n.state)
        fringe = sorted(fringe, key=lambda n: n.cost + self.problem.heuristic(n.state))
        
        # Estrae e restituisce il nodo migliore (con f(n) più basso)
        return fringe, fringe.pop(0)