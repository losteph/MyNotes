import copy

# Backtrack
class Backtracking:
    def __init__(self, csp, variable_criterion, value_criterion):
        self.csp = csp
        self.variable_criterion = variable_criterion
        self.value_criterion = value_criterion

    def backtrack_search(self, assignment):
        if self.csp.complete(assignment) and self.csp.consistent(assignment):
            return assignment

        variable = self.variable_criterion(self.csp, assignment)

        for value in self.value_criterion(self.csp, variable):
            self.csp.assign(assignment, value=value, variable=variable)

            if self.csp.consistent(assignment):
                result = self.backtrack_search(assignment)

                if result:
                    return result

            self.csp.unassign(assignment, variable=variable)

        return False

    def run(self):
        return self.backtrack_search(assignment={})



# Forward Checking
class BacktrackingFC:
    def __init__(self, csp, variable_criterion, value_criterion):
        self.csp = csp
        self.variable_criterion = variable_criterion
        self.value_criterion = value_criterion

    def forward_check(self, assignment, variable):
        new_domains = copy.deepcopy(self.csp.domains)

        for var in self.csp.variables:
            new_assignment = copy.deepcopy(assignment)
            if var not in new_assignment and var in self.csp.neighbours.get(variable, []):
                for value in new_domains[var][:]:
                    self.csp.assign(new_assignment, var, value)
                    if not self.csp.consistent(new_assignment):
                        new_domains[var] = [v for v in new_domains[var] if v != value]

                if len(new_domains[var]) == 0:
                    return False
        return new_domains

    def backtrack_search(self, assignment):
        if self.csp.complete(assignment) and self.csp.consistent(assignment):
            return assignment

        variable = self.variable_criterion(self.csp, assignment)

        for value in self.value_criterion(self.csp, variable):
            self.csp.assign(assignment, value=value, variable=variable)

            old_domains = copy.deepcopy(self.csp.domains)
            new_domains = self.forward_check(assignment, variable)

            if new_domains and self.csp.consistent(assignment):
                self.csp.domains = new_domains
                result = self.backtrack_search(assignment)

                if result:
                    return result

            self.csp.domains = old_domains
            self.csp.unassign(assignment, variable=variable)

        return False

    def run(self):
        return self.backtrack_search(assignment={})




# Arc Consistency
class AC3:
    def __init__(self, csp):
        self.csp = csp
        self.queue = self.arcs()


    def arcs(self):
        queue = []

        for var in self.csp.neighbours.keys():
            queue += [(var, neighbour) for neighbour in self.csp.neighbours[var]]

        return queue

    def remove_inconsistent_values(self, var1, var2):
        removed = False
        for value1 in self.csp.domains[var1][:]:
            constrains_results = [self.csp.consistent({var1: value1, var2: value2}) for value2 in self.csp.domains[var2]]
            if not any(constrains_results):
                self.csp.domains[var1].remove(value1)
                removed = True

        return removed

    def run(self):
        while len(self.queue)>0:
            var1, var2 = self.queue.pop(0)

            if self.remove_inconsistent_values(var1, var2):

                if len(self.csp.domains[var1]) == 0:
                    return False

                for var_n in self.csp.neighbours[var1]:
                    if var_n != var2:
                        self.queue.append((var_n, var1))

        return True
    


import random

# Local Search
class MinConflict:
    def __init__(self, csp, max_steps):
        self.csp = csp
        self.max_steps = max_steps

    def n_conflicts(self, current, variable, value):
        count = 0
        for constraint in self.csp.constraints:
            if (variable in {constraint.var1, constraint.var2} and
                    not constraint.check({**current, variable: value})):
                count += 1
        return count

    def run(self):
        current = {var: random.choice(self.csp.domains[var]) for var in self.csp.variables}

        for step in range(self.max_steps):
            if self.csp.consistent(current):
                return current

            variable = random.choice([var for var in self.csp.variables
                                      if self.n_conflicts(current, var, current[var]) > 0])

            value = min(self.csp.domains[variable],
                        key=lambda val: self.n_conflicts(current, variable, val))

            current[variable] = value

        return False
