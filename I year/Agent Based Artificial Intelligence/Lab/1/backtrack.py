class Backtracking:
    def __init__(self, csp, variableCriterion, valueCriterion):
        self.csp = csp
        self.variableCriterion = variableCriterion
        self.valueCriterion = valueCriterion
    
    def backtrackSearch(self, assignment):
        if self.csp.complete(assignment) and self.csp.consistent(assignment):
            return assignment
        
        variable = self.variableCriterion(self.csp, assignment)

        for value in self.valueCriterion(self.csp, variable):
            self.csp.assign(assignment, value=value, variable=variable)

            if self.csp.consistent(assignment):
                result = self.backtrackSearch(assignment)

                if result:
                    return result
            
            self.csp.unassign(assignment, variable=variable)
        return False
    
    def run(self):
        return self.backtrackSearch(assignment={})