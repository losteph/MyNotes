# 📘 TEORIA

## Fondamenti

- Che cos’è un azionamento elettrico e da quali blocchi fondamentali è costituito?
- Perché è necessario poter cambiare i parametri della potenza e a cosa serve la trasmissione meccanica?
- Perché, in condizioni di regime, la coppia resistente e la coppia motrice devono essere necessariamente uguali?
- Se le tensioni di fase fossero puramente costanti (continue), come risulterebbe la coppia a regime in una macchina rotante?
- Come si esegue la prova pratica per calcolare la coppia di attrito e ventilazione?
- Come si può compensare la coppia resistente dovuta all’attrito e alla ventilazione nel sistema di controllo?
- Che velocità si raggiungerebbe a regime se al motore non fosse applicata alcuna coppia di carico?

## Sistemi e Controllo

- Cosa sono le equazioni del sistema e cosa si intende per "stato" o "insieme delle variabili di stato"?
- Quando un sistema si dice lineare? (Fornire la definizione operativa in forma canonica).
- Cosa afferma il Teorema di Risposta Armonica?
- A cosa serve l’unità di controllo e come valuta l'errore?
- Nel controllo di posizione ad anello chiuso, che tipo di regolatore si utilizza (es. P o PI) e perché? (Ruolo del polo nell'origine).
- Qualsiasi funzione di ramo diretto che presenti un polo nell’origine dà vita a un sistema di tipo 1?
- Perché nel controllo di posizione (con architettura a cascata) si assume che non vi sia un disturbo, quando in realtà l'attrito esiste?
- A cosa serve il blocco di saturazione (anti-windup) nei regolatori e perché non è possibile superare la tensione nominale dell'attuatore?
- Come funziona l’inseguimento di traiettoria e come si risolve il problema della causalità per superare i limiti dell'attuatore (azione di feedforward)?
- È possibile ottenere una funzione di trasferimento unitaria nel controllo di posizione/velocità con ingressi a gradino (limiti imposti dall'ottimo simmetrico e dall'attuatore)?
- Applicando un gradino in riferimento a un controllo di forza/coppia, si può ottenere un gradino esatto in uscita tenendo conto della fisica dell'induttanza?

## Sensori, Trasduttori e Stima Parametrica

- Che differenza c'è tra l'uso di un trasduttore e l'uso di uno stimatore per valutare una variabile di controllo (vantaggi e svantaggi)?
- L'encoder fornisce la posizione elettrica o meccanica? Come fa il controllore a passare dai gradi meccanici a quelli elettrici?
- Qual è la risoluzione di posizione di un encoder incrementale e di uno in quadratura?
- Come si descrive matematicamente la posizione al passo k contando gli impulsi di un encoder e quali osservazioni pratiche bisogna fare sulla sua taratura?
- Come varia la resistenza di statore in funzione della temperatura?
- Come variano i parametri elettrici interni (flusso dei magneti e induttanza) e in base a quali grandezze?
- A cosa può servire conoscere con esattezza la tensione realmente applicata al motore, e perché nei PMSM è difficile misurarla agevolmente?

## Motori Sincroni (PMSM)

- Perché la velocità di sincronismo $\omega_s$ deve necessariamente essere uguale alla velocità rotorica $\omega_r$ a regime? (Dimostrazione basata sulla rotazione del fasore di corrente).
- Da dove deriva la funzione di trasferimento dell’asse d del motore PMSM e quali sono i suoi ingressi?
- Come funziona il disaccoppiamento nel controllo vettoriale? (Richiesta dimostrazione tramite formule).
- Che relazione c'è tra la corrente di asse diretto $i_{sd}$ e il flusso?

## Motori Asincroni a Induzione (IM)

- Perché la frequenza delle grandezze rotoriche è pari a $f_r$ (legame con lo scorrimento e la legge di Lenz)?
- Da chi dipende la velocità di sincronismo $\omega_s$ in un motore asincrono?
- Qual è il legame tra la corrente di quadratura $i_{sq}$, la coppia e lo scorrimento? Ha senso fisico che lo scorrimento dipenda da $i_{sq}$?
- Cosa accade fisicamente alla macchina se $i_{sq} < 0$?
- Controllo Scalare (V/f): Qual è la variabile controllata? Disegna lo schema a blocchi.
- Controllo Scalare (V/f): Applicando un riferimento costante, siamo sicuri di avere a regime un errore di velocità strettamente nullo?
- Controllo Scalare (V/f): Cosa succede alla caratteristica meccanica e allo scorrimento se il carico è nullo, se è nominale, o se si dimezza? (L'aumento dello scorrimento è lineare?).
- Controllo Vettoriale (FOC): Nel motore asincrono, se il controllore stima in modo errato l'angolo del flusso ($\theta_\phi$), quali sono le conseguenze sulle prestazioni?

## Altri Motori

- Motori lineari (tubolari): come sono disposti i magneti e quali sono le analogie con il sincrono rotativo per il controllo di posizione?
- Perché (e dove) si sfrutta/subisce l'effetto Pelle nelle macchine elettriche?

## Esercizi Numerici, Analisi Dinamiche

- Esercizio di regime: Motore con coppia nominale 10 Nm e velocità nominale 1000 rpm. Siamo a regime, setpoint di coppia 5 Nm. A quali valori di velocità e coppia sta lavorando l'azionamento?
- Se si effettua un controllo di velocità, è possibile conoscere con certezza il valore di coppia elettromagnetica erogata a regime?
- Esercizio Traiettoria: Ho un motore con accelerazione massima $a_{max} = 0.5$ (unità di misura da convertire) e velocità massima $\omega_{max} = 1000$ rpm. Trovare la traiettoria a tempo minimo e calcolare i tempi
- Esercizio Scorrimento: Quando applico esattamente la coppia nominale, quanto varrà lo scorrimento dell'asincrono?

# 💻 LABORATORIO (MATLAB / SIMULINK)

- Cosa fanno nello specifico i singoli blocchi all'interno dei modelli Simulink BLAC0 e BLAC1?
- I segnali di pilotaggio diretti all'inverter arrivano in coordinate $d-q$ o in coordinate di fase? Dove viene fatta la trasformazione e di quali dati ha bisogno il controllore per eseguirla?
- Modello BLAC0: Perché l'inverter è stato modellato esattamente in quel modo in Simulink?
- Quali sono le non idealità (tempi morti, ritardo ZOH) introdotte dall'inverter e che conseguenze hanno questi ritardi sui margini di fase del controllore?
- Modello BLAC0: Che ipotesi di idealità sono state fatte per lo schema?
- Modello BLAC0: Che tipo di controllo di velocità è stato implementato (anello aperto o chiuso)? Sotto quali ipotesi si ricava e si progetta la sintesi del regolatore?
- Perché nel modello BLAC0 (motore isotropo) si sceglie di forzare il riferimento $v_{sd}^* = 0$ (ovvero $i_{sd}^* = 0$)?
- Robustezza parametrica: Che valore di velocità otteniamo a regime se è presente un errore di stima parametrica? (Esempio: il controllore è tarato sul valore ideale di $R_s$, ma la $R_s$ reale della macchina è scesa al 90% a causa di variazioni termiche).
- Controllo Sensorless: È possibile fare un controllo di velocità senza l'ausilio di un encoder? Che metodo impiegheresti?
- Come funziona il controllo all'avviamento $I - f$ implementato nel modello BLAC1?
- Implementazione rampa: Assegnati i seguenti parametri d'ingresso: Corrente erogata $I = 0.7 A$, velocità $\omega_r = 200$ rpm, Coppia di carico $C_{carico} = 0.2 \cdot C_n$. Progetta la rampa da dare in riferimento al motore, implementala nello schema Simulink e mostra i grafici in uscita (visualizzando la velocità meccanica in rpm, non in rad/s).
