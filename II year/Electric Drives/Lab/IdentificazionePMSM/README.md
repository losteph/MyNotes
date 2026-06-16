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

Di questa esercitazione non ho il file matlab, perché l'abbiamo simulata in laboratorio ed abbiamo scritto i dati ed i calcoli semplicemente su un foglio.

Quando l'asse d del rotore di un PMSM è allineato con l'asse della fase A di statore, il trasduttore di posizione fornisce un angolo meccanico che moltiplicato per il numero di coppie polari sia 0° (o multiplo di 360°) idealmente.

Questa condizione in fase di installazione del trasduttore è difficile da garantire. Anche durante il funzonamento del motore, a causa delle vibrazioni o accelerazioni/decellerazioni elevati potrebbero verificarsi slittamenti tra il rotore e la parte rotante del trasduttore di posizione.

Ci sarà quindi un errore di misura statico, detto offset. La misura dell'angolo elettrico non compensata pertanto è $\theta_{rm} ) \theta_r + \theta_{offset}$.

Dove:
- $\theta_r$ è l'angolo elettrico effettivo del rotore (angolo tra asse d e fase A)
- $\theta_{rm}$ è l'angolo elettrico noto all'unità di controllo (ottenuto moltiplicando la misura meccanica grezza fornita dal sensore per il numero di coppie polari)

Se usassimo questa misura non compensata della posizione per effettuare le trasformazioni di coordinate, l'azionamento non sarebbe in grado di effettuare precisamente il controllo MTpA (quindi abbiamo una riduzione del rendimento e del carico massimo supportato).

Abbiamo visto delle tecniche per compensare l'offset. 

{
Fossimo in grado di allineare perfettamente l'asse d con quello della fase A risulta $\theta_{rm} = \theta_{offset}$. Noto quindi l'offset possiamo compensarlo digitalmente, riuscendo poi ad ottenre una misura della posizione del motore senza errori. 

Però allineare il rotore con la fase A non è possibile a causa della presenza di attriti statici e limiti di corrente erogabili dall'inverter.
}

Si utilizza infati il controllo IF, imponendo un angolo costante $\theta_{IF} = 0$ ed una corrente di asse d pari a I*, si genererebbe un campo magnetico di statore allineato con l'asse della fase A e la seguente coppia di allineamento: $Ce=-K_c I^* sin(\theta_r)$.

Il rotore non riesce ad allinearsi bene con l'asse d ma ci sarà uno scostamento che dipende dai parametri caratteristici del motore e dalla corrente erogata. Si potrebbe auentare la corrente per minimizzare questo scorrimento (se non fosse limitata quella erogata dal convertitore).

Si ricorre quindi alla strategia seguente:

- Si impone inizialmente un angolo $\theta_{IF} > 0$ per far partire il motore *da sinistra* (rispetto all'asse della fase A).
- Si riduce gradualmente l'angolo fino a raggiungere $\theta_{IF} = 0$ e si registra l'angolo ottenuto in questa condizione:

$$
\theta ' = \theta_{rm} = \theta_r + \theta_{offset} = - arcsin( \frac{Cs}{Kc I^*}) + \theta_{offset}
$$

- Si impone poi $\theta_{IF} < 0$  per far partire il motore *da destra* (rispetto all'asse della fase A).
- Si aumenta gradualmente l'angolo fino a quando $\theta_{IF} = 0$, ottenendo:

$$
\theta '' = \theta_{rm} = \theta_r + \theta_{offset} = + arcsin( \frac{Cs}{Kc I^*}) + \theta_{offset}
$$

A questo punto possiamo calcolare l'offset mediando i due dati:

$$
\theta_{offset} = \frac{\theta ' + \theta ''}{2}
$$
