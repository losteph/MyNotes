# Calibrazione Sensore e Identificazione Parametri Meccanici PMSM


## file 7, prova 1 

Si configura l'azionamento per effettuare un controllo di velocità in anello chiuso, in assenza di carico.

Nel file `rec1_458.mat` stanno i dati della prova. Abbiamo preso (N = 7) velocità di riferimento alla quale controllare il motore (0, 50, 100, 150, 300, 400, 600).

Dal file dei dati della prova notiamo che la Velocità rotorica è `Y(16)`, corrente di asse q `Y(14)`, `X` il tempo. Estraiamo quindi i valor medi di questi vettori. 

Sapendo di essere a regime ed in assenza di carico, ed avendo a disposizione una stima di Kc, possiamo ottenere una stima di B e Cd applicando il metodo dei minimi quadrati.

$$
K_c i_{qj} - B \omega_{rj} / n_p - C_d = 0
$$
nel nostro caso non dividiamo la velocità per il numero di coppie polari perché la velocità che abbiamo è già quella meccanica.
$$
y = \Phi \theta
$$
```
y = [Kc*iq1; Kc*iq2; ...; Kc*iqN];
phi = [wr1, 1; wr2, 1; ...; wrN, 1];
theta = [B; Cd]
```
$$
\theta = (\Phi^T \Phi)^{-1} \Phi^T y = [B; C_d]
$$

## file 7 brescia, prova 2

`rec1_459.mat`

iq Y(12) e w_out Y(2) ed X sempre il tempo.

qua abbiamo impostato mi sa isq pari ad 1, il motore ruota... a velocità di 800rpm o 900rpm penso, ed improvvisamente dopo tot tempo riportiamo la corrente isq = 0 e man mano scende e dobbiamo calcolarci J


## file 6 brescia

relativamente a questa esercitazione può essere utile fare qualcosa???
