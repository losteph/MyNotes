%% LAB 1: Introduzione al System Identification Toolbox
%  ==============================================================
%  Obiettivo:
%  1. Prendere confidenza con l'oggetto 'iddata'.
%  2. Stimare modelli ARX di ordine crescente.
%  3. Valutare il modello tramite FIT (Compare) e Analisi dei Residui.
%  ==============================================================

%help ident
clear all
close all
clc

%% 1. Caricamento e Preparazione Dati
% Carichiamo il dataset. I file contengono solitamente vettori Y (uscita) e U (ingresso).
% Scommentare il caso che si vuole analizzare.

% load Dati_caso1.mat
load Dati_caso2.mat
%load("Dati_caso1.mat")
%load("Dati_caso2.mat")

% Creiamo l'oggetto iddata. È il contenitore standard di Matlab per l'identificazione.
% Richiede: Uscita, Ingresso, Tempo di campionamento (qui ipotizzato 1 o non noto).
data = iddata(Y, U, t); 

% Visualizziamo i dati grezzi per capire se ci sono trend o anomalie
figure(1)
plot(data)
title('Dati Grezzi (Input/Output)');

%% 2. Pre-processing: Detrend
% La teoria lineare assume che le variazioni avvengano attorno a un punto di equilibrio.
% Rimuoviamo il valor medio (o trend costante) per lavorare sulle variazioni.
% [Rif. Teoria: Pre-processing sui Dati, rimozione offset]
data_d = detrend(data, 0);

%% 3. Suddivisione Training e Validation
% Dividiamo i dati:
% - Training: per calcolare i parametri theta (minimizzare J).
% - Validation: per verificare se il modello generalizza bene su dati nuovi.

Zc = 600; % Punto di taglio (Cut)

trainData = data_d(1:Zc);       % Primi 600 campioni per stima
testData  = data_d(Zc+1:end);   % Restanti per validazione

%% 4. Identificazione (Stima dei Modelli)
% Utilizziamo la famiglia ARX (AutoRegressive with Exogenous input).
% Struttura: A(z)y(t) = B(z)u(t-nk) + e(t)
% Sintassi: arx(dati, [na nb nk])
% na: ordine polinomio A (uscite passate)
% nb: ordine polinomio B (ingressi passati)
% nk: ritardo puro (ingressi/uscite)

% Modello 1: Ordine basso (Sotto-dimensionato?)
m1 = arx(trainData, [2 2 1]);

% Modello 2: Ordine medio
m2 = arx(trainData, [3 3 1]);

% Modello 3: Ordine alto (Rischio Overfitting?)
m3 = arx(trainData, [10 10 1]);

% Visualizziamo i parametri del modello m2 nella command window
disp('Modello m2 (ARX 3,3,1):');
m2

%% 5. Validazione (Compare & FIT)
% Confrontiamo l'uscita simulata dai modelli con l'uscita reale del set di validazione.
% L'indice FIT indica la percentuale di varianza spiegata dal modello.
% FIT = 100 * (1 - norm(y - y_hat)/norm(y - mean(y)))

figure(2);
compare(testData, m1, m2, m3);
title('Validazione sui dati di TEST');
legend('Dati Reali', 'ARX [2 2 1]', 'ARX [3 3 1]', 'ARX [10 10 1]');

%% 6. Analisi dei Residui (Bianchezza)
% Verifica fondamentale: l'errore di predizione (residuo) deve essere:
% 1. Bianco (Autocorrelazione impulsiva) -> Il modello ha catturato tutta la dinamica.
% 2. Scorrelato dall'ingresso (Cross-correlazione nulla).
% [Rif. Teoria: Analisi di Bianchezza]

figure(3);
resid(testData, m2); 
title('Analisi Residui - Modello m2');

%% Esercizi proposti
% [Esercizio 1] Ripetere l'identificazione cambiando famiglia (es. armax, oe, bj).
% [Esercizio 2] Cambiare la dimensione del set di training (Zc) e vedere come cambia il FIT.
% [Esercizio 3] Valutare i grafici di 'resid': i residui escono dalle bande di confidenza?