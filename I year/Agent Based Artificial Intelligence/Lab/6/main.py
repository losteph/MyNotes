from search import *
from strategy import *
from problem import Problem


environment = [
            ["i", " ", " ", " ", " "],
            [" ", "o", "o", " ", " "],
            [" ", " ", " ", " ", " "],
            [" ", " ", " ", " ", "g"],
            [" ", " ", " ", " ", " "]
        ]

start = (0,0) #i
end = (3, 4) #g
problem = Problem(start, end, environment)


BFsearch = Graph(problem, BreadthFirst())
print(BFsearch.run())

DFsearch = Graph(problem, DepthFirst())
print(DFsearch.run())

Asearch = Graph(problem, Astar(problem))
print(Asearch.run())
