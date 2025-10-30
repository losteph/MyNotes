class Node:
    def __init__(self, parent, action, state, cost, depth):
        self.parent = parent
        self.action = action
        self.state = state
        self.cost = cost         # g(n) - costo da start a n
        self.depth = depth
        
    def expand(self, problem):
        """
        Espande il nodo corrente generando i nodi figli.
        """
        successors = []
        for new_state, action in problem.successors(self.state):
            new_cost = self.cost + problem.cost(self.state, action)
            new_depth = self.depth + 1
            successors.append(Node(self, action, new_state, new_cost, new_depth))
        return successors

    def solution(self):
        """
        Ricostruisce il percorso (lista di azioni) 
        dallo stato iniziale a questo nodo.
        """
        path = []
        node = self
        while node.parent is not None:
            path.append(node.action)
            node = node.parent
        
        # Il percorso è stato costruito all'indietro, quindi va invertito
        return path[::-1]

    def __repr__(self):
        return str(self.state)