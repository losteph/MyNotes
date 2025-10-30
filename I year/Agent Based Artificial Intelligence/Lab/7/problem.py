import copy

# (Puoi aggiungere questa classe in fondo al tuo file problem.py esistente)

class PotionsProblem:
    
    def __init__(self, initial_state, goal_state):
        self.initial_state = initial_state
        self.goal_state = goal_state

    def actions(self, state):
        """
        Le azioni possibili sono gli scambi tra indici adiacenti.
        In una lista di 4 elementi, ci sono 3 possibili scambi:
        - Azione 0: scambia indici 0 e 1
        - Azione 1: scambia indici 1 e 2
        - Azione 2: scambia indici 2 e 3
        """
        return [0, 1, 2]

    def result(self, state, action):
        """
        Applica l'azione (scambio adiacente) e restituisce il nuovo stato.
        """
        # Converti la tupla (immutabile) in lista (mutabile) per lavorarci
        new_state_list = list(state)
        
        idx1 = action
        idx2 = action + 1
        
        # Esegui lo scambio
        new_state_list[idx1], new_state_list[idx2] = new_state_list[idx2], new_state_list[idx1]
        
        # Riconverti in tupla (immutabile) per coerenza
        return tuple(new_state_list)

    def cost(self, state, action):
        """
        Ogni scambio (azione) ha un costo unitario.
        """
        return 1
        
    def goal_test(self, state):
        """
        Controlla se lo stato corrente è quello obiettivo.
        """
        return state == self.goal_state
        
    def successors(self, state):
        """
        Genera i successori come (nuovo_stato, azione).
        Questo è codice standard.
        """
        acts = self.actions(state)
        return [(self.result(state, a), a) for a in acts]
        
    def heuristic(self, state):
        """
        Euristica A*: "Numero di pozioni fuori posto"
        Questa euristica è ammissibile (non sovrastima mai il costo)
        perché ogni pozione fuori posto dovrà essere mossa 
        almeno una volta (anche se non con uno scambio adiacente).
        """
        misplaced = 0
        for i in range(len(state)):
            if state[i] != self.goal_state[i]:
                misplaced += 1
        return misplaced