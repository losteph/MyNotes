import random

def randomVariable(csp, assigment):
    return random.choice([var for var in csp.variables if var not in assigment.keys()])

def unorderedValue(csp, variable):
    return csp.domains[variable]