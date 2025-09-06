from problem import CSP
from backtrack import Backtracking
from heuristics import *


# varibili
variables =  {"t1", "t2", "t3", "t4", "t5", 
              "f1", "f2", "f3",
              "fs1",
              "fz1", "fz2", "fz3",
              "e1", "e2"}

# domini
domains = {var: ["C1", "C2", "C3", "C4"] for var in variables}


#vincoli
maxCapacity = 6

def capacity(var, value, assignment):
    count = {c: 0 for c in domains[var]}
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
    for c in domains[var]:
        trashIn = [v for v in temp if v.startswith("t") and temp[v] == c]
        foodIn = [v for v in temp if v.startswith("f") and temp[v] == c and not v.startswith("fz") and not v.startswith("fs")]
        if trashIn and foodIn:
            return False
    return True

def freshfrozen(var, value, assigment):
    temp = assigment.copy()
    temp[var] = value
    for c in domains[var]:
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


    

constraints = [capacity, explosives, trashfood, freshfrozen, froze]



problem = CSP(variables, domains, constraints)

search = Backtracking(problem, variableCriterion=randomVariable, valueCriterion=unorderedValue)
print(search.run())