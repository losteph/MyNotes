from problem import PotionsProblem  
from search import GraphSearch
from strategy import AStarSearch     

# 1. Definizione del problema
# Le pozioni sono R, V, B, G
# (Puoi usare qualsiasi tupla di 4 elementi per lo stato iniziale)
initial_state = ('G', 'B', 'V', 'R') 
goal_state = ('R', 'V', 'B', 'G')

print(f"Problema: Riordinare le pozioni")
print(f"Stato Iniziale: {initial_state}")
print(f"Stato Obiettivo: {goal_state}")
print("-" * 30)

# 2. Creazione dell'istanza del problema
problem = PotionsProblem(initial_state, goal_state)

# 3. Creazione della strategia (AStar)
strategy = AStarSearch(problem)

# 4. Creazione dell'istanza di ricerca
search = GraphSearch(problem, strategy)

# 5. Esecuzione della ricerca
status, solution = search.run()

# 6. Stampa dei risultati
if status == 'success':
    print("Soluzione trovata!")
    print(f"Numero minimo di scambi: {len(solution)}")
    print(f"Sequenza di scambi (indici): {solution}")
else:
    print("Ricerca fallita.")