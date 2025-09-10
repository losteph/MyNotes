from adversarial_strategy import *
from game import Game, TicTacToe

# DummyGame
dummy_environment = {
    'A': {'a1': 'B', 'a2': 'C', 'a3': 'D'},
    'B': {'b1': 'E', 'b2': 'F', 'b3': 'G'},
    'C': {'c1': 'H', 'c2': 'I', 'c3': 'L'},
    'D': {'d1': 'M', 'd2': 'N', 'd3': 'O'},
}

terminal_state = {
    'E': 3,
    'F': 12,
    'G': 8,
    'H': 2,
    'I': 4,
    'L': 6,
    'M': 14,
    'N': 5,
    'O': 2
}

game1 = Game(initial='A', environment=dummy_environment, terminal=terminal_state)


# TicTacToe
game2 = TicTacToe(size=3)


# ricerca
search = AlphaBeta(game2)
print(search.run())
search = Minimax(game1)
print(search.run())