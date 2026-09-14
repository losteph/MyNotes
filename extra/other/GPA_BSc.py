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
# 16 - 17       |     D+     |   1.30
# 14 - 15       |     D      |   1.00
# 12 - 13       |     D-     |   0.70
# < 12          |     F      |   0.00
# -------------------------------------------------------------


esami = [
    {"nome": "Algorithms and Data Structures in Java", "gpa": 2.30, "letter": "C+", "cfu": 6},   
    {"nome": "Chemistry", "gpa": 2.00, "letter": "C",  "cfu": 6},   
    {"nome": "Computer Science for Engineering", "gpa": 3.30, "letter": "B+", "cfu": 6},  
    {"nome": "Economics and Business Organization", "gpa": 3.00, "letter": "B",  "cfu": 6},   
    {"nome": "General Physics", "gpa": 2.30, "letter": "C+", "cfu": 12},  
    {"nome": "Geometry and Algebra", "gpa": 2.30, "letter": "C+", "cfu": 6},   
    {"nome": "Mathematical Analysis", "gpa": 3.30, "letter": "B+", "cfu": 12},  
    {"nome": "Electronics", "gpa": 3.00, "letter": "B",  "cfu": 9},   
    {"nome": "Data Base and Information Systems", "gpa": 4.00, "letter": "A",  "cfu": 9},   
    {"nome": "Electromagnetism and Optics", "gpa": 1.70, "letter": "C-", "cfu": 6},   
    {"nome": "Fundamentals of Control Systems", "gpa": 2.70, "letter": "B-", "cfu": 12}, 
    {"nome": "Electric and Magnetic Circuits", "gpa": 4.00, "letter": "A",  "cfu": 9},   
    {"nome": "Numerical Analysis", "gpa": 3.00, "letter": "B",  "cfu": 6},   
    {"nome": "Operating Systems", "gpa": 2.00, "letter": "C",  "cfu": 12},  
    {"nome": "Applied Mechanics", "gpa": 3.00, "letter": "B",  "cfu": 6},   
    {"nome": "Digital Control", "gpa": 4.00, "letter": "A",  "cfu": 6},   
    {"nome": "Economics", "gpa": 2.00, "letter": "C",  "cfu": 12},  
    {"nome": "Electrical Machines", "gpa": 3.00, "letter": "B",  "cfu": 12},  
    {"nome": "Telecommunications", "gpa": 3.00, "letter": "B",  "cfu": 9},   
    {"nome": "Industrial Automation", "gpa": 3.30, "letter": "B+", "cfu": 6},   
    {"nome": "Measurement Fundamentals", "gpa": 3.00, "letter": "B",  "cfu": 6}    
]

def calcola_gpa(esami):
    quality_points = sum(e["gpa"] * e["cfu"] for e in esami)
    tot_credits = sum(e["cfu"] for e in esami)
    return quality_points / tot_credits

gpa_finale = calcola_gpa(esami)
tot_cfu = sum(e["cfu"] for e in esami) + 6 #3 tirocinio, #3 idoneità

print(f"Total Graded Credits (CFU): {tot_cfu}")
print(f"Cumulative GPA: {gpa_finale:.2f} / 4.00")
