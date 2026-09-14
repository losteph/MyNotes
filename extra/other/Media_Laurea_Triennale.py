esami = [
    {"nome": "Algorithms and Data Structures in Java", "voto": 22, "cfu": 6},
    {"nome": "Chemistry", "voto": 20, "cfu": 6},
    {"nome": "Computer Science for Engineering", "voto": 27, "cfu": 6},
    {"nome": "Economics and Business Organizzation", "voto": 25, "cfu": 6},
    {"nome": "General Physics", "voto": 22, "cfu": 12},
    {"nome": "Geometry and Algebra", "voto": 21, "cfu": 6},
    {"nome": "Mathematical Analysis", "voto": 26, "cfu": 12},
    {"nome": "Electronics", "voto": 24, "cfu": 9}, 
    {"nome": "Data Base and Information Systems", "voto": 30, "cfu": 9},
    {"nome": "Electromagnetism and Optics", "voto": 18, "cfu": 0}, #sarebbero 6 CFU ma i 6cfu più bassi si rimuovono
    {"nome": "Fundamentals of Control Sstems Engineering", "voto": 23, "cfu": 12},
    {"nome": "Electric and Magnetic Circuits", "voto": 29, "cfu": 9}, 
    {"nome": "Numerical Analysis", "voto": 24, "cfu": 6},
    {"nome": "Operating Systems", "voto": 20, "cfu": 12},
    {"nome": "Applied Mechanics", "voto": 24, "cfu": 6},
    {"nome": "Digital Control", "voto": 30, "cfu": 6},
    {"nome": "Economics", "voto": 20, "cfu": 12},
    {"nome": "Electrical Machines", "voto": 24, "cfu": 12},
    {"nome": "Telecommunications", "voto": 25, "cfu": 9},
    {"nome": "Industrial Automation", "voto": 27, "cfu": 6},
    {"nome": "Measurement Foundamentals", "voto": 25, "cfu": 6}
]

def media(esami):
    num = sum(c["voto"] for c in esami)
    den = sum(esami)
    return num / den

def media_ponderata_esami(esami):
    numeratore = sum(e["voto"] * e["cfu"] for e in esami)
    denominatore = sum(e["cfu"] for e in esami)
    return numeratore / denominatore

def voto_laurea(media_ponderata, bonus=1.07): #1.07 tesi compilativa (con laurea in tempo), con tesi sperimentale #1.09, con aggiunta lodi (fino a max 2 si arriverebbe a #1.11 di bonus)
    return min(round(media_ponderata * 110 / 30) * bonus, 110)


media = media_ponderata_esami(esami)
print("Media ponderata:", media)
print("Voto di laurea previsto:", voto_laurea(media))

tot_cfu = sum(e["cfu"] for e in esami)
print("cfu tot: ", tot_cfu + 6 + 3 + 3) #6 sono i cfu più bassi tolti, #3 la tesi, #3 idoneità inglese
