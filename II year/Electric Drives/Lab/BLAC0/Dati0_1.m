%========= PARAMETRI MACCHINA ==========%
Rs=3.1/2;           %Resistenza statorica
Lsd=0.005/2;        %Induttanza statrica
Lsq=Lsd;
np=2;               %Numero coppie polari
J=0.0000251;        %Momento di inerzia all'albero
B=3.8e-005;         %Coefficienti di attrito viscoso
lambdaf=0.09;       %Flusso del magnete 
PSIPM=lambdaf;
ms=3;               %Numero di fasi statoriche
Kc=ms*np*lambdaf/2;
Rfe=1100;           %Resistenza del ferro del nucleo ferromagnetico

%=========== RIFERIMENTI ===========%  
wrr=1256.6;         %Riferimento di velocità
Crn=0.6;            %Coppia di carico nominale
Cr0=0;              %Coppia di carico iniziale


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
plot (wr.Data,Ce.Data)

wr1 = wrr+ 0.2*(Rs*(Crn+B*wr/np))/(Kc*PSIPM);
delta = wr1-wrr;