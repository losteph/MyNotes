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

## file 7, prova 2

I dati raccolti in questa esercitazione sono quelli di `rec1_459.mat`, in questo caso la iq è `Y(12)` e w_out `Y(2)` ed `X` sempre il tempo.

Per questo secondo test abbiamo configurato l'azionamento per fare un controllo di corrente di asse q. Abbiamo aumentato gradualmente la corrente di asse q fino a raggiungere la velocità di rotazione desiderata (ottenuta impostando isq pari ad 1 in cui il motore ruotava a velocità di 900rpm circa). Dopo un tot tempo imponiamo bruscamente la corrente isq = 0.

Nel file .mat è stata registrata la velocita misurata durante tutto il transitorio di decellerazione.

Vogliamo determinare una stima del momento di inerzia. Analizziamo l'equazione:
$$
J = - \frac{B \omega_r + C_d n_p}{\frac{d \omega_r}{dt}}
$$
Dobbiamo selezionare però un punto preciso sulla curva per ottenere il valore di wr e la sua derivata (questo è preso in un istante in cui la isq è già nulla e la velocità è ancora elevata). Una volta selezionato il punto all'istante `t` si individuao due punti vicini tale che $t-t_1 = t_2- t$ (abbiamo sommato e sottratto a t un intervallo breve --> 0.01). Questi punti infatti devono essere vicini (er poter considerare costante la pendenza della velocità nell'intervallo di tempo delimitato da essi).

Calcoliamo quindi, la velocità media:
$$
\omega_r = \frac{\omega_r(t_2)+\omega_r(t1)}{2}
$$
approssimiamo poi la derivata con la pendenza media della curva nell'intervallo (t1, t2):
$$
\frac{d \omega_r}{dt}|_t = \frac{\omega_r(t_2) - \omega_r(t_1)}{t_2 - t_1}
$$
Possiamo quindi stimare J con la formula precedente.

## file 6

relativamente a questa esercitazione può essere utile fare qualcosa???
