class CSP:
    def __init__(self, variables, domains, constraints):
        self.variables = variables
        self.domains = domains
        self.constraints = constraints

        for var in variables:
            if var not in domains:
                raise ValueError(f"Dominio non definito per la variable {var}")
        
    def consistent(self, assignment):
        for constraint in self.constraints:
            if not constraint.check(assignment):
                return False
        return True

    def assign(self, assignment, variable, value):
        assignment[variable] = value
        return assignment
    
    def unassign(self, assignment, variable):
        if variable in assignment:
            del assignment[variable]
        return assignment
    
    def complete(self, assignment):
        return len(assignment) == len(self.variables)
