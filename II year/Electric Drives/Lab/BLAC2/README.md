# BLAC 2

1) Modifichiamo il BLAC1 in modo tale da implementare il controllo IF.

Per fare ciò dobbiamo rimuovere l'encoder e sostituirlo con la catena di blocchi: `ramp->saturation->integrator`. Impostare il coefficiente `B = 0.002` su Matlab. Effettuare un avviamento senza carico imponendo una corrente di 0.8A (da Simulink mettiamo `isq=0` e `isd=0.8*kf`) e raggiungendo 300 rpm meccanici (per fare questo impostiamo da Matlab uno script per calcolarci lo `slope = (Kc*I - B*max_speed_el - Cr0)*np/J;` dove `I=0.8; wrr=300; max_speed_el = wrr*2*pi*np/60;`). Il valore dello slope è quello da mettere nella rampa su Simulink, la saturazione è impostata a \[124,-50\] (124 è la max_speed_el - 1 che abbiamo trovato, 50 non ricordo perché l'abbiamo impostata).

Lo *slope* è esattamente la massima accelerazione di avviamento. Per verificarla mediante una simulazione possiamo vedere tre casi:

- impostando la slope al valore trovato (914) il motore riesce a partire, si vedono oscillazioni che si assesta sulla velocità di regime.
<img width="1080" height="515" alt="image" src="https://github.com/user-attachments/assets/06e5c8ae-0fe5-4c4c-a6b1-ae98ec9ffd50" />

- se impostiamo una slope più alta (1500) il campo statorico accelera troppo in fretta ed il motore perde il passo (la velocità reale crolla, oscilla in modo caotico o si ferma, non riuscendosi ad agganciarsi alla rampa).
<img width="1102" height="780" alt="image" src="https://github.com/user-attachments/assets/e999083f-b93e-4c81-b08e-a40cf689b0c4" />

- impostando una pendenza dolce (500) il motore insegue la rampa con oscillazioni più piccole ed un comportamento più stabile.
<img width="1080" height="792" alt="image" src="https://github.com/user-attachments/assets/1d6594a3-37af-4570-9afd-960bbbd5b4f0" />

Abbiamo inoltre plottato l'angolo di carico (differenza tra la posizione elettrica generata dall'integratore e quella reale del motore). Affinche il motore rimanga agganciato $\delta$ non deve superare i 90° elettrici ($\pi/2$ rad).
<img width="722" height="442" alt="image" src="https://github.com/user-attachments/assets/74337494-1878-4dd7-9cae-a790ea06cdac" />
(Se con lo slope a 914 l'angolo di carico sfiora i 90° senza superarli abbiamo dimostrato correttamente).

2) Imponendo una corrente di 0.8A (come prima) e riferimento di velocità nullo (lo slope della rampa lo impostiamo uguale a zero o sostituiamo proprio la rampa con un constant pari a 0). Impostando una coppia di carico che passa da 0 a 0.3Nm da 0.1s a 0.4s. Per impostare la coppia di carico applichiamo uno slope di valore 1 (ottenuto da $\frac{\Delta Cr}{\Delta t}=(0.3-0)/(0.4-0.1)=1$ che parte a 0.1s (come richiesto da traccia, e per quel valore di slope scelto otteniamo coppia pari a 0.3 in prossimità di 0.4), per evitare poi che non superi il valore di 0.3 mettiamo un blocco di saturazione. Determinare analiticamente che corrente di asse q ed asse d assorbe il motore a regime (tramite breve formule lato matlab).

```Matlab
% Esercizio 2: Calcolo correnti a rotore bloccato con carico
I_rif = 0.8;      % Corrente imposta [A]
Cr_finale = 0.3;  % Coppia di carico a regime [Nm]

% Calcolo analitico
iq_regime = Cr_finale / Kc;
% Verifica di fattibilità: la corrente richiesta non deve superare il modulo totale
if iq_regime > I_rif
    disp('Attenzione: Il motore perde il passo! La coppia richiesta supera quella massima erogabile.');
else
    id_regime = sqrt(I_rif^2 - iq_regime^2);
    delta_angolo = asin(iq_regime / I_rif) * (180/pi); % Angolo in gradi per comodità
    
    fprintf('--- RISULTATI ANALITICI ESERCIZIO 2 ---\n');
    fprintf('Corrente iq a regime: %.3f A\n', iq_regime);
    fprintf('Corrente id a regime: %.3f A\n', id_regime);
    fprintf('Angolo di carico (delta): %.2f gradi elettrici\n', delta_angolo);
end
```

Verificare il calcolo mediante simulazione (aprendo i grafici di isd ed isq vediamo che dopo un tempo pari a 0.4 si assensta ai valori trovati analiticamente prima).

3) Mantenendo la stessa corrente e carico, dopo che il carico ha ragiunto il suo valore di regime, si effettui l'avviamento della macchina con la massima accelerazione possibile (da determinare analiticamente) e raggiungendo 200 rpm meccanici.

Qua adesso dopo aver fatto l'esercitazione 2, riprendiamo i calcoli della prima esercitazione, per calcolarci il nuovo slope (questa volta bisogna modificare però la `wr=200;` e sottrarre dalla formule `Cr=0.3` (prima invece stava `Cr0=0;`). Rieseguiamo la simulazione e rimane tutto uguale.
