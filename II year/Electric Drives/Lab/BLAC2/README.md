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


2) Imponendo una corrente di 0.8A e riferimento di velocità nullo. Impostando una coppia di carico che passa da 0 a 0.3Nm da 0.1s a 0.4s. Determinare analiticamente che corrente di asse q ed asse d assorbe il motore a regime. Verificare il calcolo mediante simulazione.

3) Mantenendo la stessa corrente e carico, dopo che il carico ha ragiunto il suo valore di regime, si effettui l'avviamento della macchina con la massima accelerazione possibile (da determinare analiticamente) e raggiungendo 200 rpm meccanici.


prova prova
