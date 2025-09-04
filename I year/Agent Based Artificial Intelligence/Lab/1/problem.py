class PetProblem:
    """
    Modella il problema degli animali come un CSP.
    Variabili: animali
    Domini: ['Area1', 'Area2', 'Area3']
    Vincolo: max 3 animali per area
    """

    def __init__(self, pets):
        self.variables = pets
        self.domains = {pet: ["Area1", "Area2", "Area3"] for pet in pets}

    def is_consistent(self, assignment):
        """
        Controlla che l'assegnazione parziale rispetti il vincolo di capacità.
        """
        # Conta quante variabili sono già assegnate per area
        counts = {"Area1": 0, "Area2": 0, "Area3": 0}
        for pet, area in assignment.items():
            counts[area] += 1
            if counts[area] > 3:
                return False
        return True