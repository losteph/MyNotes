from node import Node

class GraphSearch:
    def __init__(self, problem, strategy):
        self.problem = problem 
        self.strategy = strategy
        self.fringe = []
        self.closed = [] 

    def run(self):
        # Inizializza la frontiera con il nodo radice
        self.fringe.append(Node(None, None, self.problem.initial_state, 0, 0))

        while True:
            # 1. Controlla se la frontiera è vuota
            if len(self.fringe) == 0:
                return "fail", []
            
            # 2. Seleziona un nodo dalla frontiera usando la strategia
            self.fringe, node = self.strategy.select(self.fringe)
            if not node:
                return "fail", []
            
            # 3. Controlla se è il nodo obiettivo
            if self.problem.goal_test(node.state):
                return "success", node.solution()
            
            # 4. Espandi il nodo SOLO se non è già stato visitato
            if node.state not in self.closed:
                # Aggiungilo alla lista dei visitati
                self.closed.append(node.state) # += [node.state] nei tuoi appunti [cite: 154]
                
                fringe_states = [n.state for n in self.fringe]
                
                self.fringe += [new_node for new_node in node.expand(self.problem) 
                                if new_node.state not in fringe_states and 
                                   new_node.state not in self.closed]