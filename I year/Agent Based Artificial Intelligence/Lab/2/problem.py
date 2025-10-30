class HanoiPlus:
    # in questa classe ho aggiunto la possibilità di cambiare il numero di dischi semplicemente quando viene richiamata la classe
    def __init__(self, Ndisk, InitialState=None, GoalState=None):
        self.Ndisk = Ndisk
        if InitialState is None:
            self.InitialState = (tuple(range(Ndisk, 0, -1)), (), ())
        else:
            self.InitialState = InitialState
        if GoalState is None:
            self.GoalState = ((), (), tuple(range(Ndisk, 0, -1)))
        else:
            self.GoalState = GoalState 

    def action(self, state):
        actions = []
        for i in range(3):
            if len(state[i]) > 0:
                disk = state[i][-1] #prendo il disco in cima
                for j in range(3):
                    if i != j:
                        if len(state[j]) == 0 or state[j][-1] > disk:
                            actions.append((i,j)) #muovo il disco dal palo i al palo j
        return actions

    def result(self, state, action):
        i, j = action
        state = [list(rod) for rod in state]
        disk = state[i].pop()
        state[j].append(disk)
        return tuple(tuple(rod) for rod in state)

    def successors(self, state):
        acts = self.actions(state)
        return [(self.result(state, a), a) for a in acts]

    def goal_test(self, state):
        return state == self.GoalState

    def cost(self, state, action):
        return 1

    def heuristic(self, state):
        # numero di dischi non nella posizione finale (euristica semplice)
        misplaced = 0
        for rod_idx in range(3):
            for disk in state[rod_idx]:
                misplaced += 1
        return misplaced



class Hanoi:
    # in questa invece bisogna specificare gli stati manualmente da main
    def __init__(self, InitialState, GoalState):
        self.InitialState = InitialState
        self.GoalState = GoalState
    
    def action(self, state):
        actions = []
        for i in range(3):
            if len(state[i]) > 0:
                disk = state[i][-1] #prendo il disco in cima
                for j in range(3):
                    if i != j:
                        if len(state[j]) == 0 or state[j][-1] > disk:
                            actions.append((i,j)) #muovo il disco dal palo i al palo j
        return actions

    def result(self, state, action):
        i, j = action
        state = [list(rod) for rod in state]
        disk = state[i].pop()
        state[j].append(disk)
        return tuple(tuple(rod) for rod in state)

    def successors(self, state):
        acts = self.action(state)
        return [(self.result(state, a), a) for a in acts]

    def goal_test(self, state):
        return state == self.GoalState

    def cost(self, state, action):
        return 1

    """
    def heuristic(self, state):
        # numero di dischi non nella posizione finale (euristica semplice)
        misplaced = 0
        for rod_idx in range(3):
            for disk in state[rod_idx]:
                misplaced += 1
        return misplaced
    """

    def heuristic(self, state):
        return len(state[0]) + len(state[1]) # Stima: quanti dischi NON sono sull'asta C (indice 2)
