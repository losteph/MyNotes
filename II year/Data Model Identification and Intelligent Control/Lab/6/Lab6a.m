%% LAB 6a: Identificazione Statica con Reti Neurali
%  ==============================================================
%  OBIETTIVO:
%  1. Usare una Rete Neurale (NN) per approssimare una funzione non lineare.
%  2. Capire l'effetto del numero di neuroni (Underfitting vs Overfitting).
%  3. Osservare come la rete generalizza su dati rumorosi.
%  [Rif. Teoria: Cap. 8 - Neural Networks, Approssimatori Universali]
%  ==============================================================

clear all
close all
clc

%% 1. Generazione della Funzione da Identificare
% Funzione statica: y = f(x) + n
% Vogliamo che la NN impari f(x) guardando solo i dati rumorosi y.

x = 0 : 0.04 : 4; % Input
% Funzione vera (somma di esponenziali)
y0 = 4.3 * (exp(-x) - 4*exp(-2*x) + 3*exp(-3*x)); 

% Aggiunta Rumore
sigma = 0.2; % Deviazione standard del rumore
n = sigma * randn(size(y0)); 
y = y0 + n; % Output misurato

figure(1)
plot(x, y0, 'r--', 'LineWidth', 2); hold on;
plot(x, y, 'b.');
legend('Funzione Vera (senza rumore)', 'Dati Misurati (con rumore)');
title('Problema di Function Approximation');

%% 2. Creazione e Addestramento Reti Neurali
% Usiamo 'feedforwardnet' per creare una rete multistrato.
% L'argomento è un vettore che indica i neuroni per ogni strato nascosto.

% --- Rete 1: Semplice (4 neuroni) ---
% Struttura parsimoniosa, dovrebbe generalizzare bene.
net1 = feedforwardnet(4);
net1.trainParam.epochs = 200; % Numero massimo di epoche
net1.trainParam.showWindow = false; % Nasconde la GUI di training (opzionale)

% Training
% MATLAB divide automaticamente in Training, Validation e Test set
fprintf('Addestramento Rete 1 (Semplice)...\n');
[trained_net1, TR1] = train(net1, x, y);

% --- Rete 2: Complessa (Overfitting) ---
% Struttura esagerata: 2 strati da 10 neuroni ciascuno.
% Rischia di imparare a memoria il rumore dei singoli punti.
net2 = feedforwardnet([20 20]); 
net2.trainParam.epochs = 500;
net2.trainParam.showWindow = false;

fprintf('Addestramento Rete 2 (Complessa)...\n');
[trained_net2, TR2] = train(net2, x, y);

%% 3. Simulazione e Confronto
% Usiamo le reti addestrate per predire l'uscita su tutto l'asse x.

y_est1 = sim(trained_net1, x);
y_est2 = sim(trained_net2, x);

figure(2)
plot(x, y0, 'r--', 'LineWidth', 2); hold on; % Vero
plot(x, y, 'b.', 'MarkerSize', 5);           % Dati Rumorosi
plot(x, y_est1, 'g-', 'LineWidth', 2);       % Rete Semplice
plot(x, y_est2, 'm-', 'LineWidth', 1.5);     % Rete Complessa

legend('Funzione Vera', 'Dati Rumorosi', 'NN Semplice (4N)', 'NN Complessa (20+20N)');
title('Confronto Generalizzazione vs Overfitting');
ylim([-0.5 1.5]);

% ANALISI DEI RISULTATI:
% - La linea VERDE (Rete Semplice) dovrebbe essere liscia e vicina alla rossa.
% - La linea VIOLA (Rete Complessa) potrebbe "ballare" inseguendo i puntini blu,
%   dimostrando che ha imparato il rumore invece della funzione.

%% Esercizio Proposto
% Prova ad aumentare il rumore (sigma = 0.7) e vedi quale rete "soffre" di più.