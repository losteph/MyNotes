# BLAC 0

La traccia è presente nel file `BLAC0.pdf`. I file da caricare (Load Data) sono nel file `Dati0_1.m`, runnare quel file Matlab prima di aprire i relativi file Simulink.

---

## Controllo della velocità

Lo schema a blocchi è stato realizzato da zero in classe copiando quello in figura ed allegato come `BLAC0_velocità.slx`.

1) Verifichiamo che la simulazione fornisce i risultati analoghi a quelli del professore.

Osserviamo che il riferimento di velocità è applicato all'istante t = 0s mentre la coppia di carico è applicata dopo 0.05s. Il riferimento di velocità è pari a wrr = 1256 [rad/s], mentre la coppia di carico è pari a 0.6 [Nm].

<img width="752" height="534" alt="image" src="https://github.com/user-attachments/assets/7b62e622-4d49-48f3-991b-605b33564b9b" />

<img width="519" height="451" alt="image" src="https://github.com/user-attachments/assets/0e7ebc22-eba0-4802-a167-ead4bc62e174" />

2) Dobbiamo aumentare vsq' dopo l'applicazione della coppia di carico per riportare la velocità di rotazione al valore wrr. Dobbiamo aumentarla di un valore pari a $Cr \frac{Rs}{Kc}$. 

Per aumentare aggiungiamo uno step che parte a 0.05s che assume valore `Crn*Rs/Kc`.
  

3) Osservando la velocità effettiva notiamo che persiste un lieve scostamento dalla velocità di riferimento, dovuto *alle perdite per attrito e ventilazione*: $B (\omega_r / n_p)$; allora dobbiamo incrementare ancora la vsq' di `(B*wrr*Rs)/(np*Kc)` per raggiungere precisamente il riferimento di velocità (aggiungendo un altro blocco step oppure al blocco di prima sommando quel contributo).

<img width="685" height="535" alt="image" src="https://github.com/user-attachments/assets/80d313bf-2cdf-4e79-ad9e-073404c1be7e" />


5) La caratteristica meccanica confrontata con la traiettoria coppia-velocità ottenuta nella simulazione con carico ed a vuoto è:

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

5) Per calcolare analiticamente la velocità che verrebbe raggiunta a regime se la resistenza stimata fosse il 120% di quella reale del motore (dopo aver compensato le perdite di attrito e ventilazione), modifichiamo il Matlab aggiungendo:

```
wr1 = wrr+ 0.2*(Rs*(Crn+B*wr/np))/(Kc*PSIPM);
delta = wr1 - wrr;
```

Ouppure analogamente dal Simulink creando questo schema:

<img width="935" height="500" alt="image" src="https://github.com/user-attachments/assets/07ec2a35-514d-497c-ae51-8dbd7e7e84c1" />

(Poi dobbiamo modificare dal simulink nel subsystem controllore gli step aggiunti nei punti 2 e 3, moltiplicando la resistenza per 1.2).

---

## Controllo di coppia

Lo schema a blocchi è stato realizzato da zero in classe copiando quello nel pdf ed allegato come `BLAC0_coppia.slx`

Verifichiamo che i grafici ottenuti sono simili a quelli del prof.

<img width="694" height="511" alt="image" src="https://github.com/user-attachments/assets/cafb850f-507f-40af-bd8e-c013b933ed7e" />

Con questo schema Simulink non funziona ed esce sbagliato il grafico, rispetto a quello che dovrebbe essere. Esce così:

<img width="1554" height="911" alt="image" src="https://github.com/user-attachments/assets/245d20b0-9444-429c-8ef5-70750fe4dd7b" />

Quindi ho implementato il tutto tramite codice:
```
%% Controllo di coppia (terzo grafico)

% 1. Definizione delle Variabili (Assumendo che siano vettori)
% I blocchi 'To Workspace' salvano i dati come strutture timeseries (spesso con nome 'variabile.Data').
% Se i tuoi dati sono salvati direttamente come array (es. nome_variabile.Data),
% devi accedere solo alla parte numerica. Esempio:
% Ce_data = Ce.Data; 
% Cr_data = Cr.Data;
% wr_data = wr.Data;
Ce = out.Ce.Data;
Cr = out.Cr.Data;
wr = out.wr.Data;

% *** N.B.: Se i tuoi dati sono già nel Workspace come array di tipo double, usa direttamente i loro nomi (Ce, Cr, wr). ***

% 2. Calcolo dei componenti del Carico (se non calcolati in Simulink)
% Assumendo che 'B', 'np', e l'attrito costante siano definiti nel Workspace
% (Adattare questa parte al tuo modello specifico!)
B_attrito = B / np; % Carico viscoso normalizzato B/np [cite: 221] 
Carico_viscoso = B_attrito * wr; % B*wr/np

% 3. Creazione del Grafico (Coppia/Carico vs. Velocità)
figure; % Apre una nuova finestra grafica

% Plot della Coppia Elettromagnetica (Ce) vs. Velocità (wr)
plot(wr, Ce, 'b', 'DisplayName', 'Ce'); 
hold on; % Mantiene il grafico per aggiungere altre curve

% Plot del Carico Totale (Cr) vs. Velocità (wr)
plot(wr, Cr, 'r', 'DisplayName', 'Cr');

% Plot del Carico Viscoso B*wr/np vs. Velocità (wr)
plot(wr, Carico_viscoso, 'g', 'DisplayName', 'B*wr/np');

% Calcolo e Plot del Carico Totale (Ce + Attrito Viscoso) vs. Velocità
% Questo dipende dal modo in cui il tuo Carico Totale è definito nel modello!
% Se nel tuo modello il carico totale è C_tot = Cr + B*wr/np (o simile):
C_tot = Cr + Carico_viscoso; 
plot(wr, C_tot, 'k', 'DisplayName', 'Cr + B*wr/np'); 

% 4. Formattazione e Legenda
xlabel('Electric Speed [rad/s]');
ylabel('Electromagnetic torque and load torque [Nm]');
title('BLAC Motor Torque and Load vs Speed');
legend('show', 'Location', 'SouthEast');
grid on;
hold off;
```

Ottenendo quindi il grafico corretto:

<img width="1124" height="634" alt="image" src="https://github.com/user-attachments/assets/269ddaff-6087-4e50-b92a-8c49660d0b57" />


- Modifichiamo il modello del convertitore introducendo un errore di attuazione di -0.5V sulla tensione di asse q. Aggiungendo nell'inverter i blocchi come è fatto nel Simulink (invece di essere unitario come di base quello ideale considerato prima).


- Calcoliamo analiticamente che coppia viene prodotta a regime dal motore lasciando inalterato il controllore.

- Verifichiamo il calcolo con la simulazione

- Ridisegnare il controllore per ottenere a regime la coppia desiderata

- Verificare il nuovo design con la simulazione
