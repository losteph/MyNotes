class CSP:
    def __init__(self, variables, domains, constraints):
        self.variables = variables
        self.domains = domains
        self.constraints = constraints
        
    def consistent(self, assignment):
        for var in assignment:
            value = assignment[var]
            for constraint in self.constraints:
                if not constraint(var, value, assignment):
                    return False
        return True


    def complete(self, assignment):
        return len(assignment) == len(self.variables)
    
    def assign(self, assignment, variable, value):
        assignment[variable] = value
        return assignment
    
    def unassign(self, assignament, variable):
        assignament.pop(variable)
        return assignament