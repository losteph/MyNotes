from problem import StreetProblem, EightTilesProblem, HanoiTower
from informed_strategy import *
from search import TreeSearch, GraphSearch

# StreetProblem
streets = {
    'Andria': {'Corato': 3, 'Trani': 2},
    'Corato': {'Andria': 3, 'Ruvo': 2, 'Trani': 3, 'Altamura': 4},
    'Altamura': {'Corato': 4, 'Ruvo': 3, 'Modugno': 5},
    'Ruvo': {'Corato': 2, 'Bisceglie': 3, 'Terlizzi': 2, 'Altamura': 3},
    'Terlizzi': {'Ruvo': 2, 'Molfetta': 2, 'Bitonto': 2},
    'Bisceglie': {'Trani': 2, 'Ruvo': 3, 'Molfetta': 2},
    'Trani': {'Andria': 2, 'Corato': 3, 'Bisceglie': 2},
    'Molfetta': {'Bisceglie': 2, 'Giovinazzo': 2, 'Terlizzi': 2},
    'Giovinazzo': {'Molfetta': 2, 'Modugno': 3, 'Bari': 2, 'Bitonto': 3},
    'Bitonto': {'Modugno': 3, 'Giovinazzo': 3, 'Terlizzi': 2},
    'Modugno': {'Bitonto': 3, 'Giovinazzo': 3, 'Bari': 2, 'Altamura': 5, 'Bitetto': 1},
    'Bari': {'Modugno': 2, 'Giovinazzo': 2, 'Bitetto': 2},
    'Bitetto': {'Bari': 2, 'Modugno': 1}
}

cities_coords = {
    'Andria': (41.2316, 16.2917),
    'Corato': (41.1465, 16.4147),
    'Altamura': (40.8302, 16.5545),
    'Ruvo': (41.1146, 16.4886),
    'Terlizzi': (41.1321, 16.5461),
    'Bisceglie': (41.243, 16.5052),
    'Trani': (41.2737, 16.4162),
    'Molfetta': (41.2012, 16.5983),
    'Giovinazzo': (41.1874, 16.6682),
    'Bitonto': (41.1118, 16.6902),
    'Modugno': (41.0984, 16.7788),
    'Bari': (41.1187, 16.852),
    'Bitetto': (41.040, 16.748)
}

problem1 = StreetProblem("Modugno", "Bari", streets, cities_coords)


# EightTiles
initial_state = [1, 2, 0, 5, 4, 3, 7, 6, 8]
goal_state = [0, 1, 2, 3, 4, 5, 6, 7, 8]

problem2 = EightTilesProblem(initial_state, goal_state)


# HanoiTower
InitialState = ((3,2,1), (), ())
GoalState = ((), (), (3,2,1))

problem3 = HanoiTower(InitialState=InitialState, GoalState=GoalState)



# varie strategie
strategy1 = GreedySearch(problem3)
strategy2 = AStarSearch(problem3)


# ricerca
search = TreeSearch(problem3, strategy2)
print(search.run())
search = GraphSearch(problem3, strategy2)
print(search.run())
# è possibile modificare il tipo di problema e la strategia di ricerca utilizzata cambiando i numeri (molto intuitivo)