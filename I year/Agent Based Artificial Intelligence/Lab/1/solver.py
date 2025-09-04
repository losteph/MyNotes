def backtracking_search(problem):
    """
    Avvia la ricerca CSP.
    """
    return backtrack({}, problem)


def backtrack(assignment, problem):
    """
    Algoritmo ricorsivo di backtracking.
    """
    # Caso base: tutte le variabili assegnate
    if len(assignment) == len(problem.variables):
        return [assignment.copy()]

    # Prendi una variabile non ancora assegnata
    unassigned = [v for v in problem.variables if v not in assignment][0]
    solutions = []

    for value in problem.domains[unassigned]:
        # Prova un dominio
        assignment[unassigned] = value
        if problem.is_consistent(assignment):
            solutions.extend(backtrack(assignment, problem))
        # Backtrack
        del assignment[unassigned]

    return solutions
