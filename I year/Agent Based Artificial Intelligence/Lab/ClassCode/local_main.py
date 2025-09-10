from problem import EightQueenProblem
from local_strategy import *
import random

def scheduler(time):
    initial_temp = 1000
    lamb = 0.001
    return initial_temp - lamb * time


# EightQueenProblem
initial = [random.randint(0, 7) for _ in range(8)]
problem = EightQueenProblem(initial)


# simulated annealing 
search = SimulatedAnnealingSearch(problem=problem, max_time=100000, schedule=scheduler)
print(search.run())

# algoritmo genetico
search = GeneticAlgorithm(problem=problem,
                          population_size=100,
                          max_generation=1000,
                          state_len=8,
                          gene_pool=[i for i in range(8)],
                          mutation_rate=0.3)

print(search.run())

# singolo hill climbing
search = HillClimbingSearch(problem)
print(search.run())

# più ricerche "hill climbing" con generazione degli stati casuale ad ogni istanza dell'algoritmo
it = 0
while True:
    it+=1
    search = HillClimbingSearch(problem=EightQueenProblem([random.randint(0, 7) for _ in range(8)]))
    result = search.run()
    if result[1] == 0:
        print(f"Found Solution {result[0].state}, with cost {result[1]}, after {it} iterations.")
        break