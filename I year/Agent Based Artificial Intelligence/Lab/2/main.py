from problem import Hanoi, HanoiPlus
from search import GraphSearch
from strategy import *

InitialState = ((3,2,1), (), ())
GoalState = ((), (), (3,2,1))

problem = Hanoi(InitialState=InitialState, GoalState=GoalState)

Otherproblem = HanoiPlus(3)

print("DFS: ")
search = GraphSearch(problem, DepthFirstSearch())
print(search.run())

print("A*: ")
search = GraphSearch(problem, AStarSearch(problem))
print(search.run())

"""
Dopo averlo runnato otteniamo la soluzione dopo 
- 9 iterazione usando la DFS
- 7 iterazioni usando A*
"""