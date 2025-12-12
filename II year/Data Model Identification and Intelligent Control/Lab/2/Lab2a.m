%% LAB 2: Analisi Asintotica e Consistenza (Caso ARX)
%  ==============================================================
%  OBIETTIVO:
%  Valutare come l'errore di stima dei parametri (theta_0 - theta_hat)
%  diminuisce all'aumentare del numero di dati N usati per l'identificazione.
%  Dimostrare la CONSISTENZA dello stimatore ARX quando il sistema reale
%  appartiene alla famiglia ARX (S in M).
%  ==============================================================

clear 
clc
close all

%% 1. Generazione del Sistema da Identificare (MGD)

% Definizione asse temporale
Ts = 0.01;
Tend = 10000 * Ts;
t = (0:Ts:Tend)';
Nmax = length(t);

% Creazione del sistema in tempo continuo e discretizzazione
% (Un sistema a fase non minima: zeri fuori dal cerchio unitario)
G = zpk(10, [-20 -20 -50 -100], -400*50*10);
Gz = c2d(G, Ts); 

% Visualizzazione risposta impulsiva vera
figure(1)
impulse(Gz)
title('Risposta Impulsiva Sistema Vero')

% Estrazione polinomi veri (approssimati per semplicità di lettura)
% A_true e B_true rappresentano il vettore Theta_0
A = [1.00 -2.61  2.49 -1.02 0.15];
B = [0    -0.02 -0.03  0.05 0.01];

% Creazione oggetto idpoly per la simulazione
% ARX: A(z)y = B(z)u + e
NoiseVariance = 1e-7; % Rumore molto basso per vedere bene la convergenza
S = idpoly(A, B, [], [], [], NoiseVariance, Ts);

%% 2. Generazione Dati Simulati

% Creiamo esplicitamente i segnali di ingresso e rumore
U = randn(Nmax, 1); % Ingresso (Rumore Bianco)
E = randn(Nmax, 1); % Rumore Bianco (Incertezza)

% Simulazione del sistema
% Usiamo la sintassi esplicita suggerita dal prof: passiamo sia U che E.
Y = sim(S, [U E]);

% Creazione oggetto iddata contenitore
Dati = iddata(Y, U, Ts);
Dati.InputName = 'Ingresso';
Dati.OutputName = 'Uscita';

%% 3. Identificazione con N crescente (Stile Lineare)

% Creazione manuale dei sotto-insiemi di dati
Dati50   = Dati(1:50);
Dati100  = Dati(1:100);
Dati200  = Dati(1:200);
Dati500  = Dati(1:500);
Dati1000 = Dati(1:1000);
Dati9500 = Dati(1:9500);

% Stima dei modelli ARX (Struttura corretta: [4 4 1])
% Notare: Non usiamo cicli for, definiamo ogni modello esplicitamente.
m50   = arx(Dati50,   [4 4 1]);
m100  = arx(Dati100,  [4 4 1]);
m200  = arx(Dati200,  [4 4 1]);
m500  = arx(Dati500,  [4 4 1]);
m1000 = arx(Dati1000, [4 4 1]);
m9500 = arx(Dati9500, [4 4 1]);

%% 4. Calcolo dell'Errore Parametrico

% Estrazione parametri stimati (tfdata) per ogni modello
[B_50, A_50]     = tfdata(m50, 'v');
[B_100, A_100]   = tfdata(m100, 'v');
[B_200, A_200]   = tfdata(m200, 'v');
[B_500, A_500]   = tfdata(m500, 'v');
[B_1000, A_1000] = tfdata(m1000, 'v');
[B_9500, A_9500] = tfdata(m9500, 'v');

% Calcolo errore massimo (Norma infinito o confronto diretto)
% Confrontiamo i vettori stimati con quelli veri (A e B definiti all'inizio)

MaxErr_m50   = max([abs(B_50 - B)   abs(A_50 - A)]);
MaxErr_m100  = max([abs(B_100 - B)  abs(A_100 - A)]);
MaxErr_m200  = max([abs(B_200 - B)  abs(A_200 - A)]);
MaxErr_m500  = max([abs(B_500 - B)  abs(A_500 - A)]);
MaxErr_m1000 = max([abs(B_1000 - B) abs(A_1000 - A)]);
MaxErr_m9500 = max([abs(B_9500 - B) abs(A_9500 - A)]);

% Creazione vettore errori per il plot
N_vector = [50 100 200 500 1000 9500];
Parameter_Error = [MaxErr_m50 MaxErr_m100 MaxErr_m200 MaxErr_m500 MaxErr_m1000 MaxErr_m9500];

% Stampa risultati numerici in Command Window
fprintf('N = 50   -> Errore: %f\n', MaxErr_m50);
fprintf('N = 500  -> Errore: %f\n', MaxErr_m500);
fprintf('N = 9500 -> Errore: %f\n', MaxErr_m9500);

%% 5. Plot dei Risultati

figure(2)
% Usiamo semilogx per vedere meglio l'asse X logaritmico
semilogx(N_vector, Parameter_Error, '-o', 'LineWidth', 2)
grid on
xlabel('Numero di Campioni (N)')
% Interpreter none evita il warning sui simboli LaTeX
ylabel('Errore Parametrico Max ||Theta_0 - Theta_hat||', 'Interpreter', 'none')
title(['Analisi di Consistenza ARX (Varianza Rumore: ' num2str(NoiseVariance) ')'])

%% ESERCIZI PROPOSTI (Per studio autonomo)
% 1. Prova a cambiare NoiseVariance a 1e-4 o 1e-2. 
%    La curva scende ancora, ma partirà da valori più alti.
% 2. Prova a usare una famiglia sbagliata (es. arx con ordini [2 2 1]).
%    Vedrai che l'errore non andrà a zero (Polarizzazione).