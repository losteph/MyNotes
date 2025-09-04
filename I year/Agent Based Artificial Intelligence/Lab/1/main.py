from problem import PetProblem
from solver import backtracking_search

if __name__ == "__main__":
    # Animali della traccia
    pets = ["Jack", "Melody", "Zara", "Diego", "Leo", "Cacco", "Lil", "Camillo"]

    # Inizializza problema
    problem = PetProblem(pets)

    # Trova soluzioni
    solutions = backtracking_search(problem)

    print(f"Trovate {len(solutions)} soluzioni valide:\n")
    for i, sol in enumerate(solutions[:10], 1):  # Mostro solo le prime 10
        print(f"Soluzione {i}: {sol}")
