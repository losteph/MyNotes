# BLAC 2

1) Modifichiamo il BLAC1 in modo tale da implementare il controllo IF.

Per fare ciò dobbiamo rimuovere l'encoder e sostituirlo con la catena di blocchi: `ramp->saturation->integrator`. Impostare il coefficiente `B = 0.002` su Matlab. Effettuare un avviamento senza carico imponendo una corrente di 0.8A (da Simulink mettiamo `isq=0` e `isd=0.8*kf`) e raggiungendo 300 rpm meccanici (per fare questo impostiamo da Matlab uno script per calcolarci lo `slope = (Kc*I - B*max_speed_el - Cr0)*np/J;` dove `I=0.8; wrr=300; max_speed_el = wrr*2*pi*np/60;`). Il valore dello slope è quello da mettere nella rampa su Simulink, la saturazione è impostata a \[124,-50\].

Determinare analiticamente la massima accelerazione di avviamento e verificarla mediante una simulazione.

4) Imponendo una corrente di 0.8A e riferimento di velocità nullo. Impostando una coppia di carico che passa da 0 a 0.3Nm da 0.1s a 0.4s. Determinare analiticamente che corrente di asse q ed asse d assorbe il motore a regime. Verificare il calcolo mediante simulazione.

5) Mantenendo la stessa corrente e carico, dopo che il carico ha ragiunto il suo valore di regime, si effettui l'avviamento della macchina con la massima accelerazione possibile (da determinare analiticamente) e raggiungendo 200 rpm meccanici.


prova prova
