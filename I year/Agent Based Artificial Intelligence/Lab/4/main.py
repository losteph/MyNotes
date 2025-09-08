from game import GridGame
from minimax import Minimax
from alphabeta import AlphaBeta


game = GridGame(N=4, depth=10)

state = game.initial_state
search = Minimax(game)

print("Initial MAX position:", state["max_pos"])
print("Initial MIN position:", state["min_pos"])
print("Special cells:", state["special"])

# esempio: scegli la prossima mossa di MAX
best_action = search.run(state)
print("Best action for MAX (minimax):", best_action)


search = AlphaBeta(game)
print("Best action for MAX (alfa-beta):", search.run(state))