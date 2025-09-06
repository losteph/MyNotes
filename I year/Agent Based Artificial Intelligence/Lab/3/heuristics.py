import random

def randomVariable(csp, assignment):
    return random.choice([var for var in csp.variables if var not in assignment.keys()])

def unorderedValue(csp, variable):
    return csp.domains[variable]
