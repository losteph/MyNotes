set I; # Sedie o Tavoli
set J := 1..4; # Workstation

param pWS{I,J}; # tempo necessario alla lavorazione del pezzo i per la workstation j
param M; # big number

var tWS{i in I,j in J} >= 0; # tempo di inizio della lavorazione del pezzo i sulla workstation j
var y{j in J} binary; # 1 (Sedia lavorata prima del Tavolo), 0 (Sedia lavorata dopo il Tavolo)
var K >= 0; # makespan

minimize tempoLavorazione: K; # funzione obiettivo

#Vincoli di Precedenza (Ordine di lavorazione per ogni mobile)
# Per la Sedia (S)
s.t. Precedenza_S_WS2: tWS["S", 2] >= tWS["S", 1] + pWS["S", 1];
s.t. Precedenza_S_WS3: tWS["S", 3] >= tWS["S", 2] + pWS["S", 2];
s.t. Precedenza_S_WS4: tWS["S", 4] >= tWS["S", 3] + pWS["S", 3];
# Per il Tavolo (T)
s.t. Precedenza_T_WS3: tWS["T", 3] >= tWS["T", 2] + pWS["T", 2];
s.t. Precedenza_T_WS1: tWS["T", 1] >= tWS["T", 3] + pWS["T", 3];
s.t. Precedenza_T_WS4: tWS["T", 4] >= tWS["T", 1] + pWS["T", 4];

#Vincoli Disgiuntivi (per l'utilizzo delle Workstation condivise)
s.t. Disgiuntivo_S_prima_T {j in J}: tWS["S", j] + pWS["S", j] <= tWS["T", j] + M * (1 - y[j]);
s.t. Disgiuntivo_T_prima_S {j in J}: tWS["T", j] + pWS["T", j] <= tWS["S", j] + M * y[j];

#Vincoli per il Makespan
s.t. Makespan_Sedia: K >= tWS["S", 4] + pWS["S", 4];
s.t. Makespan_Tavolo: K >= tWS["T", 4] + pWS["T", 4];