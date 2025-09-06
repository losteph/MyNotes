from csp import CSP
from problem import AreaCapacity
from backtrack import Backtracking
from heuristics import *

# VARIABILI
variables = ["Jack", "Melody", "Zara", "Diego", "Leo", "Cacco", "Lil", "Camillo"]
# DOMINI
domain = ["A1", "A2", "A3"]
domains = {variable:  domain for variable in variables}
# VINCOLI
max_pet_per_A = 3
constraints = [
    AreaCapacity("A1", max_pet_per_A),
    AreaCapacity("A2", max_pet_per_A),
    AreaCapacity("A3", max_pet_per_A)
]

# PROBLEMA
problem = CSP(variables=variables, domains=domains, constraints=constraints)

# RICERCA
search = Backtracking(problem, variableCriterion=randomVariable, valueCriterion=unorderedValue)
print(search.run())