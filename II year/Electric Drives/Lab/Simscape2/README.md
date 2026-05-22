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


