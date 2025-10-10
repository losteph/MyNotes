esami = [
    {"nome": "Statistical and Mathematical Methods for Machine Learning", "voto": 30, "cfu": 6},
    {"nome": "Distributed Measurement and Data Acquisition Systems", "voto": 28, "cfu": 6},
    {"nome": "Internet of Things", "voto": 28, "cfu": 6},
    {"nome": "Dynamical System Theory", "voto": 28, "cfu": 6},
    {"nome": "Estimation and Control of Dynamical Systems", "voto": 27, "cfu": 6},
    {"nome": "Digital Business", "voto": 26, "cfu": 6},
    {"nome": "Optimization and Control", "voto": 25, "cfu": 6},


    {"nome": "Artificial Intelligence and Machine Learning", "voto": 19, "cfu": 3}, #sarebbero 12 cfu ma tolgo i 9cfu più bassi
    {"nome": "Embedded Control", "voto": 24, "cfu": 6},
  

    {"nome": "Electric Drives", "voto": 19, "cfu": 12},
    {"nome": "Data Model Identification and Intelligent Control", "voto": 30, "cfu": 6},
    {"nome": "Robotics", "voto": 24, "cfu": 12},
    {"nome": "Model Predictive Control", "voto": 25, "cfu": 6},
]

def media(esami):
    num = sum(c["voto"] for c in esami)
    den = sum(esami)
    return num / den

def media_ponderata_esami(esami):
    numeratore = sum(e["voto"] * e["cfu"] for e in esami)
    denominatore = sum(e["cfu"] for e in esami)
    return numeratore / denominatore

def voto_laurea(media_ponderata, bonus=1.09):
    return min(round(media_ponderata * 110 / 30) * bonus, 110)


media = media_ponderata_esami(esami)
print("Media ponderata:", media)
print("Voto di laurea previsto:", voto_laurea(media))

tot_cfu = sum(e["cfu"] for e in esami)
print("cfu tot: ", tot_cfu + 9 + 18 + 6) #9 sono i cfu più bassi tolti, #18 la tesi, #6 il tirocinio