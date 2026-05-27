# BLAC 0

La traccia è presente nel file `BLAC0.pdf`. I file da caricare (Load Data) sono nel file `Dati0_1.m`, runnare quel file Matlab prima di aprire i relativi file Simulink.

---

## Controllo della velocità

Lo schema a blocchi è stato realizzato da zero in classe copiando quello in figura ed allegato come `BLAC0_velocità.slx`.

1) Verifichiamo che la simulazione fornisce i risultati analoghi a quelli del professore.

Osserviamo che il riferimento di velocità è applicato all'istante t = 0s mentre la coppia di carico è applicata dopo 0.05s. Il riferimento di velocità è pari a wrr = 1256 [rad/s], mentre la coppia di carico è pari a 0.6 [Nm].



2) Dobbiamo aumentare vsq' dopo l'applicazione della coppia di carico per riportare la velocità di rotazione al valore wrr. Dobbiamo aumentarla di un valore pari a $Cr \frac{Rs}{Kc}$. 

Per aumentare aggiungiamo uno step che parte a 0.05s che assume valore `Crn*Rs/Kc`.
  

3) Osservando la velocità effettiva notiamo che persiste un lieve scostamento dalla velocità di riferimento, dovuto *alle perdite per attrito e ventilazione*: $B (\omega_r / n_p)$; allora dobbiamo incrementare ancora la vsq' di `(B*wrr*Rs)/(np*Kc)` per raggiungere precisamente il riferimento di velocità (sommando un altro blocco step oppure al blocco di prima sommiamo quel contributo).

4) La caratteristica meccanica confrontata con la traiettoria coppia-velocità ottenuta nella simulazione con carico ed a vuoto è:

<img width="1000" height="690" alt="blac0fig4" src="https://github.com/user-attachments/assets/3c6358b3-e749-4a17-8566-f232faa2c7a6" />


abbiamo aggiunto al codice questa parte:
```
% Calcolo della media su intervalli di campioni
vsq1_vuoto = mean(vsq1.Data(300:400));
vsq1_carico = mean(vsq1.Data(700:1000));
w0_vuoto=vsq1_vuoto/PSIPM;
w0_carico=vsq1_carico/PSIPM;
w_vuoto=0:w0_vuoto;
w_carico=0:w0_carico;
Ce_vuoto= Kc/Rs*PSIPM*(w0_vuoto-w_vuoto);
Ce_carico= Kc/Rs*PSIPM*(w0_carico-w_carico);

figure(3), hold on;
plot(w_vuoto,Ce_vuoto)
plot(w_carico,Ce_carico)
plot(wr.Data,Ce.Data)
```

5) Per calcolare analiticamente la velocità che verrebbe raggiunta a regime se la resistenza stimata fosse il 120% di quella reale del motore (dopo aver compensato le perdite di attrito e ventilazione), abbiamo:
```
wr1 = wrr+ 0.2*(Rs*(Crn+B*wr/np))/(Kc*PSIPM);
delta = wr1 - wrr;
```

Dal simulink poi abbiamo fatto così:

<img width="935" height="500" alt="image" src="https://github.com/user-attachments/assets/07ec2a35-514d-497c-ae51-8dbd7e7e84c1" />


---

## Controllo di coppia

Lo schema a blocchi è stato realizzato da zero in classe copiando quello in figura ed allegato come `BLAC0_coppia.slx`
