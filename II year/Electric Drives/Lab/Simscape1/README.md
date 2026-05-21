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

Verificare che le equazioni elettriche dq siano soddisfatte a regime a 700 rad/s e carico 0.6 Nm. Usando i valori dei parametri tenendo conto delle variazioni parametriche e per la verifica 

Calcolare la potenza attiva, le perdite e la potenza meccanica totale a regime a 314 rad/s e 0.2 Nm. Verificare che la potenza meccanica è pari alla potenza attiva meno le perdite per effetto Joule: 

Calcolare l'efficienza (potenza meccanica trasferita al carico diviso la potenza attiva) nello stesso punto. Ripetere la simulazione e ricalcolare l'efficienza nello stesso punto dopo aver modificato le temperature impostando: 
- il rotore a 70°C
- lo statore a 90°C

---

## Svolgimento 1

Dopo aver scaricato tutti i file, servirà aprire solamente `Script_caricamento_dati_simscape1.m` e `Simscape1.mdl`.

Dobbiamo modificare le temperature dallo script Matlab per avere come richiesto: `Trotor=50;` e `Tphase=75;`.

Impostiamo il riferimento di velocità ($t = 0$ a 314) dal Simulink, dal blocco:

<img width="170" height="110" alt="image" src="https://github.com/user-attachments/assets/77b73eca-3c68-4905-831c-f26f0d58a1c6" />

andiamo a modificare il grandino esistente come segue:

<img width="750" height="400" alt="image" src="https://github.com/user-attachments/assets/be146c9e-0d5a-40f1-96ea-13637b349930" />

il valore viene moltiplicato per $60/2 \pi$ perché è riportato da rad/sec in RPM.

Aggiungiamo poi un ulteriore blocco Step per rappresentare il riferimento ($t = 0.2$ a 700):

<img width="900" height="388" alt="image" src="https://github.com/user-attachments/assets/7150b7b8-bbca-4e12-bc40-ef3084a2ea8b" />

Quindi:

<img width="750" height="400" alt="image" src="https://github.com/user-attachments/assets/7f4ca0a5-7c5e-473b-b6b3-81b85e418b8b" />

In questo caso facciamo $(700-314) 60 / 2 \pi$ perché avevamo già 314 all'istante iniziale e dobbiamo aggiungere solo i restanti per arrivate come velocità totale a 700.

Modifichiamo poi la coppia di carica lavorando su questo blocco:

<img width="300" height="130" alt="image" src="https://github.com/user-attachments/assets/db01b17e-8367-44e5-84a3-bbd628b05cd0" />

Qua adesso quindi mettiamo due blocchi gradino:

<img width="631" height="376" alt="image" src="https://github.com/user-attachments/assets/69bc5c86-c4ba-4119-ab09-d1dd238996f5" />

Nel primo impostiamo lo Step time 0.12 ed il Final value a 0.2; nel secondo impostiamo Step time 0.32 e Final value a 0.4 (perché per lo stesso ragionamento di prima, avendo già 0.2 mancano solo 0.4 per arrivare ad un totale di 0.6).

Questo blocco con la "i" apre tutti gli schemi di Sensing Current:

<img width="277" height="193" alt="image" src="https://github.com/user-attachments/assets/936619b8-9873-485f-9310-94a0c5dd29ca" />

Dentro questo schema dobbiamo aggiungere uno scope per visualizzare le correnti di fase così facendo:

<img width="1007" height="522" alt="image" src="https://github.com/user-attachments/assets/a9b8d65a-e9ac-42ab-b0b0-f82bd24fa3ea" />

Troviamo aprendolo:

<img width="1917" height="1013" alt="image" src="https://github.com/user-attachments/assets/3aec29b4-0c8a-4188-bf0d-982ab788c769" />

che il perido di una corrente di fase (ogni corrente di fase ha lo stesso periodo ne prendiamo una campione), troviamo un valore di $T_c=0.0045s$ quindi facendo l'inversa troviamo unfa frequenza $f=222Hz$ che moltiplicata per $2 \pi$ otteniamo $\omega = 1395.5 rad/s$. 

<img width="1100" height="626" alt="image" src="https://github.com/user-attachments/assets/b059d3bc-7f66-4988-8462-ba805baa0cad" />

Vedendo la velocità meccanica del rotore notiamo che è pari a $700rad/s$, ma questo è normale, perchè sappiamo che la velocità elettrica è pari a quella meccanica per $n_p$ (numero di paia di poli), quindi per visualizzare correttamente quella elettrica avrei dovuto aggiungere un blocco Gain con dentro $n_p$.

Il prossimo passo è aggiungere un blocco Scope per visualizzare l'asse q (l'asse d è 0):

<img width="271" height="215" alt="image" src="https://github.com/user-attachments/assets/a2cc8442-e4bf-4099-8e3c-272f98924484" />

ed otteniamo:

<img width="1433" height="917" alt="image" src="https://github.com/user-attachments/assets/11bda961-c601-45a5-b421-79cfb3c22619" />

notiamo quindi che la corrente $i_q \approx 8A$ e (riprendendo l'immagine delle correnti di fase) notiamo che l'ampiezza delle sinusoidi anche era 8. Quindi la trasformazione è conservqativa rispetto alle ampiezze.

Le due equazioni elettriche a regime i d-q sono:

$$
v_{sd} = R_s i_{sd} - \omega_r L_q i_{sq} 
$$
$$
v_{sq} = R_s i_{sq} + \omega_r L_d i_{sd} + \omega_r \psi_{PM}
$$

e dobbiamo creare queste due equazioni su simulink e verificare :

<img width="1218" height="710" alt="image" src="https://github.com/user-attachments/assets/7f5fbdbc-ddc4-4bba-a197-44f4bfb80b10" />

Zoomiamo meglio sui collegamenti:

<img width="612" height="611" alt="image" src="https://github.com/user-attachments/assets/0d399208-e53f-4337-91f1-23c4727ba4fc" />

I risultati che otteniamo per l'asse d sono:

<img width="1432" height="882" alt="image" src="https://github.com/user-attachments/assets/fb18d1e3-be31-4651-91bd-1f3d1b303bb5" />

per l'asse q:

<img width="1517" height="888" alt="image" src="https://github.com/user-attachments/assets/be5182f8-d81f-4a09-97cf-09f8a32d0323" />

ACCORTEZZE:

Abbiamo preso la Rs_tot da Variable Resistance

<img width="1657" height="677" alt="image" src="https://github.com/user-attachments/assets/45e9b4e4-b06c-4e36-92e1-000dd4c53f5b" />

che troviamo in questo blocco:

<img width="590" height="387" alt="image" src="https://github.com/user-attachments/assets/f5bf8670-cd85-4188-b4a4-621e39b65bf1" />

la wr la prendiamo da qua:

<img width="366" height="342" alt="image" src="https://github.com/user-attachments/assets/13366215-ef9c-4ec3-b03f-0ffd711b9e7d" />

per gli altri blocchi come Lsq e Lsd prendiamo i Constant e gli sostituiamo dentro il valore (NON usiamo i workspace perchè altrimenti da errori di timeseries). Le moltiplicazioni vanno fatte a due a due se no si bugga, non so perchè.

Per $\psi_{PM}$ prendiamo sempre un blocco constant è sciviamo Psim è lo moltiplichiamo per un Gain contenente:

<img width="300" height="200" alt="image" src="https://github.com/user-attachments/assets/e35323b3-1b8a-47ae-9982-70d749b4dd29" />

perché dipende varia con la temperatura.

Il prossimo passo è calcolare:
- __potenza attiva__ (potenza eletrica in ingresso): $P_{in} = \frac{3}{2} (v_{sd}i_{sd} + v_{sq}i_{sq}$
- __perdite elettriche__ $P_{joule} = \frac{3}{2} (i_{sd}^2 + i_{sq}^2)$
- __potenza meccanica__ $P_m = Kc i_{sq} \omega_r / n_p$
- _L'efficienza elettrica_ (rendimento della conversione elettromeccanica dell'energia) $\eta_ele = P_{out} / P_{in}$ 

(Queste richieste sono solo per il tratto a 314rad/s e con carico 0.2Nm, quindi possiamo rimuovere volendo gli altri step che abbiamo usato per aumentare la velocità ed il carico).

Ho svolto queste ultime richieste in Simulink come segue:

<img width="1577" height="725" alt="image" src="https://github.com/user-attachments/assets/1d5eeb1c-6cfa-4168-89f5-3dcde9096b1c" />

Queste modifiche le abbiamo fatte all'interno del SubSystem Variable:

<img width="298" height="230" alt="image" src="https://github.com/user-attachments/assets/1f627ee1-8e29-4107-8ea5-be7ac80828e3" />

Abbiamo usato i blocchi: product, divide, square, constant, gain, from, sum, per comporre le varie equazioni teoriche e plottarle poi in degli scope (per confrontare e verificare che potenza meccanica e potenza elettrica al meno delle perdite sono uguali, abbiamo plottato tramite un mux entrambi i grafici in un unico plot e risultano simili).

Abbiamo usato il blocco Moving Average per pulire il segnale dalle oscillazioni ad alta frequenza (ripple) per leggere il valore medio a regime.

Ripetiamo poi l'intera simulazione modificando (come abbiamo fatto all'inizio, dallo script Matlab)  `Trotor=70;` e `Tphase=90;`.

---

## Esercitazion 2

Modificare la simulazione imponendo che il carico venga interrotto a 0.40 sec e che la macchina si fermi a 0.45 sec, con durata della simulazione 0.65 sec.

Effettuare una simulazione con disaccoppiamento perfetto a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo di lavoro di 1 ora.

Effettuare una simulazione con disaccoppiamento imperfetto ($80% \cdot Lsd$) a 6000 rpm e $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

Effettuare una simulazione senza disaccoppiamento a 6000 rpm $C_r = \frac{2}{4} \dot C_{rn}$ a 100°C. Calcolare l'energia totale dissipata per effetto Joule. Calcolare l'energia che verrebbe dissipata per un ciclo lavorativo di 1 ora.

---

## Soluzione 2
