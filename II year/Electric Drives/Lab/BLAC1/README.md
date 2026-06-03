# BLAC 1

Fare il load dei dati tramite lo script Matlab `Blac_1d.m`.

Lasciando il circuito inalterato otteniamo i seguenti grafici (quello a sinistra rappresenta il confronto tra corrente di asse q di riferimento e quella misurata all'uscita del motore, e quello a destra rappresenta il confronto tra la velocità wrref e wr). In questo caso dal matlab si è commentato il progetto 1 e ho scommentato il progetto 2 dal Matlab. Le curve in blu è il   

<img width="1399" height="500" alt="image" src="https://github.com/user-attachments/assets/c5b30e49-68ba-4535-b57a-c31233d5748d" />


1) Al posto del riferimento di velocità a gradino ed il filtro di smoothing mettiamo un riferimento a rampa (a pendenza limitata), scegliendo la pendenza del riferimento (slope del blocco Ramp) in modo da garantire che la corrente durante il transitorio di velocità sia contenuta entro due volte la corrente nominale (anche durante un avviamento con coppia di carico nominale). La corrente deve mantenersi entro 2 volte la corrente nominale durante la fase di accelerazione, sono ammessi valori anche maggiori durante il transitorio iniziale della corrente (perché è di breve durata).


Le figure per evidenziare l'andamento della velocità e delle correnti durante l'avviamento sono:


Ripetendo la simulazione in assenza di coppia di carico durante l'avviamento:



2) Rimuoviamo dal diagramma a blocchi il regolatore di velocità ed utilizziamo un gradino di ampiezza pari a `0.6*kf` applicato nell'istante t=0 per generare il riferimento di corrente secondo l'asse q. Realizziamo le simulazioni del controllo di corrente in assenza di coppia di carico.
