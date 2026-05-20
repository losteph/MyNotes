# Simscape

---

## Traccia 1

Effettuare la simulazione per:
* t = 0.00 sec (impostando il riferimento di velocità a 314 rad/s)
* t = 0.12 sec (impostando la coppia di carico a 0.2 Nm)
* t = 0.20 sec (impostando il riferimento di velocità a 700 rad/s)
* t = 0.32 sec (impostando la coppia di carico a 0.6 Nm)

Impostare inoltre:
- temperatura di rotore a 50°C
- temperatura di statore a 75°C

Confrontare la velocità elettrica del rotore e la pulsazione delle correnti di fase a regime.

Confrontare le correnti di fase e quelle dq a regime, verificando che il modulo delle correnti dq sia uguale all'ampiezza delle correnti di fase.

Verificare che le equazioni elettriche dq siano soddisfatte a regime a 700 rad/s e carico 0.7 Nm. Usando i valori dei parametri tenendo conto delle variazioni parametriche e per la verifica 

Calcolare la potenza attiva, le perdite e la potenza meccanica totale a regime a 314 rad/s e 0.2 Nm. Verificare che la potenza meccanica è pari alla potenza attiva meno le perdite per effetto Joule: 

Calcolare l'efficienza (potenza meccanica trasferita al carico diviso la potenza attiva) nello stesso punto. Ripetere la simulazione e ricalcolare l'efficienza nello stesso punto dopo aver modificato le temperature impostando: 
- il rotore a 70°C
- lo statore a 90°C

---

## Svolgimento 1

Dopo aver scaricato tutti i file, servirà aprire solamente `Script_caricamento_dati_simscape1.m` e `Simscape1.mdl`.

Dobbiamo modificare le temperature dallo script Matlab per avere come richiesto: `Trotor=50;` e `Tphase=75;`.

Impostiamo il riferimento di velocità ($t = 0$ a 314) dal Simulink, dal blocco:

<img width="163" height="102" alt="image" src="https://github.com/user-attachments/assets/77b73eca-3c68-4905-831c-f26f0d58a1c6" />

andiamo a modificare il grandino esistente come segue:

<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/be146c9e-0d5a-40f1-96ea-13637b349930" />

il valore viene moltiplicato per $60/2 \pi$ perché è riportato da rad/sec in RPM.


---

## Esercitazion 2

Modificare la simulazione imponendo che il carico venga interrotto a 0.40 sec e che la macchina si fermi a 0.45 sec, con durata della simulazione 0.65 sec.

Effettuare una simulazione con disaccoppiamento perfetto a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo di lavoro di 1 ora.

Effettuare una simulazione con disaccoppiamento imperfetto ($80% \cdot Lsd$) a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

Effettuare una simulazione senza disaccoppiamento a 6000 rpm $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

---

## Soluzione 2
