# BLAC 0

La traccia è presente nel file `BLAC0.pdf`. I file da caricare (Load Data) sono nel file `Dati0.m`, runnare quel file Matlab prima di aprire i relativi file Simulink.

---

## Controllo della velocità

Lo schema a blocchi è stato realizzato da zero in classe copiando quello in figura ed allegato come `BLAC0_velocità.slx`.

1) Verifichiamo che la simulazione fornisce i risultati analoghi a quelli del professore.

Osserviamo che il riferimento di velocità è applicato all'istante t = 0s mentre la coppia di carico è applicata dopo 0.05s. Il riferimento di velocità è pari a wrr = 1256 [rad/s], mentre la coppia di carico è pari a 0.6 [Nm].



2) Dobbiamo aumentare vsq' dopo l'applicazione della coppia di carico per riportare la velocità di rotazione al valore wrr. Dobbiamo aumentarla di un valore pari a $Cr \frac{Rs}{Kc}$. 

Per aumentare aggiungiamo uno step che parte a 0.05s che assume valore `Crn*Rs/Kc`.
  

3) Osservando la velocità effettiva notiamo che persiste un lieve scostamento dalla velocità di riferimento, dovuto *alle perdite per attrito e ventilazione*: $B (\omega_r / n_p)$; allora dobbiamo incrementare ancora la vsq' di `(B*wrr*Rs)/(np*Kc)` per raggiungere precisamente il riferimento di velocità (sommando un altro blocco step oppure al blocco di prima sommiamo quel contributo).

4) La caratteristica meccanica confrontata con la traiettoria coppia-velocità ottenuta nella simulazione con carico ed a vuoto è:


abbiamo aggiunto al codice questa parte:
```

```

5) Per calcolare analiticamente la velocità che verrebbe raggiunta a regime se la resistenza stimata fosse il 120% di quella reale del motore (dopo aver compensato le perdite di attrito e ventilazione), abbiamo:
```

```

---

## Controllo di coppia

Lo schema a blocchi è stato realizzato da zero in classe copiando quello in figura ed allegato come `BLAC0_coppia.slx`
