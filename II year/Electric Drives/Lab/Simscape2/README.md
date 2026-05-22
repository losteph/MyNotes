# Simscape2

Modificare la simulazione imponendo che il carico venga interrotto a 0.40 sec e che la macchina si fermi a 0.45 sec, con durata della simulazione 0.65 sec.

Effettuare una simulazione con disaccoppiamento perfetto a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo di lavoro di 1 ora.

Effettuare una simulazione con disaccoppiamento imperfetto ($80% \cdot Lsd$) a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

Effettuare una simulazione senza disaccoppiamento a 6000 rpm $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

---

## Soluzione

Dallo script Matlab impostiamo `tend = 0.65`, che sarà poi messo in alto in Simulink come Stop Time della simulazione:

<img width="400" height="100" alt="image" src="https://github.com/user-attachments/assets/8d959478-1435-40b2-ae3c-7bae1864eca5" />

Riprendendo i casi precedenti (Simscape1), dal simulink impostiamo wr che parte a t=0.00 di 314rad/s (trasformato in RPM), ed il carico che parte a t=0.12 ed è di 0.2Nm. Adesso però dobbiamo aggiungere un blocco sommatore (modificato di segni) in cui sottraiamo due Step, uno a t=0.40 che tolga il carico di 0.2Nm e l'altro che spenga la macchina a t=0.45.

Adesso per i prossimi punti impostiamo la velocità dei blocchi Step di prima: la velocità a 6000rpm e la coppia resistente come 0.5*Crn. ed impostiamo le Trotor e Tphase a 100°C.

Per calcolare l'energia totale dissipata per effetto Joule (e quella che verrebbe dissipata per un cuclo lavorativo di 1h, ho creato questo schema di blocchi per ricreare le formule teoriche):

<img width="1468" height="612" alt="image" src="https://github.com/user-attachments/assets/a3bd938d-d139-4e1c-a988-4a98651f6232" />

Per verificare i 3 casi:

- disaccoppiamento perfetto
- disaccoppiamento imperfetto (80% di Lsd)
- senza disaccoppiamento

Dobbiamo modificare questo blocco:

<img width="507" height="603" alt="image" src="https://github.com/user-attachments/assets/d1d996f9-568a-4fd9-96b7-660785b1d556" />

Nello specifico dobiamo modificare nella sezione Inner Loop:

<img width="753" height="977" alt="image" src="https://github.com/user-attachments/assets/1a0c0b77-9bf7-4fd7-94dd-9849e6c5a52c" />

i valori di Lsd, Lsq e Psim:

1) Lascio tutto come sta nella foto
2) Moltiplico per 0.8 Lsd
3) Imposto tutti e 3 i parametri a zero 
