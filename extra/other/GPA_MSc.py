# TABELLA DI CONVERSIONE UFFICIALE (WES / Standard US)
# -------------------------------------------------------------
# Voto IT (/30) | Lettera US | Punti GPA
# -------------------------------------------------------------
# 30 e Lode     |     A+     |   4.33
# 29 - 30       |     A      |   4.00
# 28            |     A-     |   3.70
# 26 - 27       |     B+     |   3.30
# 24 - 25       |     B      |   3.00
# 23            |     B-     |   2.70
# 21 - 22       |     C+     |   2.30
# 19 - 20       |     C      |   2.00
# 18            |     C-     |   1.70
# < 18          |     F      |   0.00
# -------------------------------------------------------------


esami = [
    {"nome": "Statistical and Mathematical Methods for Machine Learning", "gpa": 4.33, "letter": "A+", "cfu": 6},   
    {"nome": "Digital Business", "gpa": 3.30, "letter": "B+",  "cfu": 6},   
    {"nome": "Distributed Measurementand Data Acquisition Systems", "gpa": 3.70, "letter": "A-", "cfu": 6},  
    {"nome": "Dynamical Systems Theory", "gpa": 3.70, "letter": "A-",  "cfu": 6},   
    {"nome": "Estimation and Control of Dynamical Systems", "gpa": 3.30, "letter": "B+", "cfu": 6},  
    {"nome": "Internet of Things", "gpa": 3.70, "letter": "A-", "cfu": 6},   
    {"nome": "Machine Learning and AI", "gpa": 3.00, "letter": "B", "cfu": 12},  
    {"nome": "Optimization and Control", "gpa": 3.00, "letter": "B",  "cfu": 6},   
    {"nome": "Data Model Identification", "gpa": 3.70, "letter": "A-",  "cfu": 6},   
    {"nome": "Electric Drives", "gpa": 3.00, "letter": "B", "cfu": 12},   
    {"nome": "Model Predictive Control", "gpa": 3.30, "letter": "B+", "cfu": 6}, 
    {"nome": "Embedded Control", "gpa": 3.00, "letter": "B",  "cfu": 6},    
    {"nome": "Robotics", "gpa": 2.70, "letter": "B-",  "cfu": 12}    
]

def calcola_gpa(esami):
    quality_points = sum(e["gpa"] * e["cfu"] for e in esami)
    tot_credits = sum(e["cfu"] for e in esami)
    return quality_points / tot_credits

gpa_finale = calcola_gpa(esami)
tot_cfu = sum(e["cfu"] for e in esami) + 6 + 18 #6 tirocinio, #18 tesi

print(f"Total Graded Credits (CFU): {tot_cfu}")
print(f"Cumulative GPA: {gpa_finale:.2f} / 4.00")