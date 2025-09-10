from problem import CSP
from heuristics import *
from csp_strategy import *

# Pets
class AreaCapacity:
    def __init__(self, area, maxCapacity):
        self.area = area
        self.maxCapacity = maxCapacity
    
    def check(self, assignment):
        count = 0
        for var, assignedArea in assignment.items():
            if assignedArea == self.area:
                count += 1
        return count <= self.maxCapacity
    
variables1 = ["Jack", "Melody", "Zara", "Diego", "Leo", "Cacco", "Lil", "Camillo"]

domain1 = ["A1", "A2", "A3"]
domains1 = {variable1:  domain1 for variable1 in variables1}

constraints1 = [
    AreaCapacity("A1", 3),
    AreaCapacity("A2", 3),
    AreaCapacity("A3", 3)
]

problem1 = CSP(variables=variables1, domains=domains1, constraints=constraints1)



# MapColoring
class DifferentValues:
    def __init__(self, var1, var2):
        self.var1 = var1
        self.var2 = var2

    def check(self, assignment):
        value1 = assignment.get(self.var1)
        value2 = assignment.get(self.var2)
        if value1 and value2:
            return value1 != value2
        return True

class DifferentValues:
    def __init__(self, var1, var2):
        self.var1 = var1
        self.var2 = var2

    def check(self, assignment):
        value1 = assignment.get(self.var1)
        value2 = assignment.get(self.var2)
        if value1 and value2:
            return value1 != value2
        return True


variables2 = ['WA', 'NT', 'Q', 'NSW', 'V', 'SA', 'T']

domain2 = ['red', 'green', 'blue']
domains2 = {variable2: domain2 for variable2 in variables2}

constraints2 = [
    DifferentValues('SA', 'WA'),
    DifferentValues('SA', 'NT'),
    DifferentValues('SA', 'Q'),
    DifferentValues('SA', 'NSW'),
    DifferentValues('SA', 'V'),
    DifferentValues('WA', 'NT'),
    DifferentValues('NT', 'Q'),
    DifferentValues('Q', 'NSW'),
    DifferentValues('NSW', 'V')
]


problem2 = CSP(variables=variables2, domains=domains2, constraints=constraints2)


# Containers
variables3 =  {"t1", "t2", "t3", "t4", "t5", 
              "f1", "f2", "f3",
              "fs1",
              "fz1", "fz2", "fz3",
              "e1", "e2"}


domains3 = {var: ["C1", "C2", "C3", "C4"] for var in variables3}


maxCapacity = 6

def capacity(var, value, assignment):
    count = {c: 0 for c in domains3[var]}
    temp = assignment.copy()
    temp[var] = value
    for v in temp:
        count[temp[v]] += 1
    return all(c <= maxCapacity for c in count.values())

def explosives(var, value, assigment):
    temp = assigment.copy()
    temp[var] = value
    explosives = [temp[v] for v in temp if v.startswith("e")]
    return len(explosives) == len(set(explosives))

def trashfood(var, value, assigment):
    temp = assigment.copy()
    temp[var] = value
    for c in domains3[var]:
        trashIn = [v for v in temp if v.startswith("t") and temp[v] == c]
        foodIn = [v for v in temp if v.startswith("f") and temp[v] == c and not v.startswith("fz") and not v.startswith("fs")]
        if trashIn and foodIn:
            return False
    return True

def freshfrozen(var, value, assigment):
    temp = assigment.copy()
    temp[var] = value
    for c in domains3[var]:
        FreezeIn = [v for v in temp if v.startswith("fz") and temp[v] == c]
        FreshIn = [v for v in temp if v.startswith("fs") and temp[v] == c]
        if FreshIn and FreezeIn:
            return False
    return True


def froze(var, value, assigment):
    temp = assigment.copy()
    temp[var] = value
    frozen = [temp[v] for v in temp if v.startswith("fz")]
    return not frozen or len(set(frozen)) == 1


constraints3 = [capacity, explosives, trashfood, freshfrozen, froze]


problem3 = CSP(variables3, domains3, constraints3)


# ricerche
search = Backtracking(problem1, variable_criterion=random_variable, value_criterion=unordered_value)
print(search.run())
search = Backtracking(problem1, variable_criterion=minimum_remaining_values, value_criterion=unordered_value)
print(search.run())
search = Backtracking(problem1, variable_criterion=degree_heuristic, value_criterion=unordered_value)
print(search.run())

search = BacktrackingFC(problem1, variable_criterion=random_variable, value_criterion=unordered_value)
print(search.run())

search = MinConflict(problem1, 100)
print(search.run())


ac3 = AC3(problem1)