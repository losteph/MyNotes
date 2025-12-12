%% LAB 6b: Identificazione Dinamica con Reti Neurali
%  ==============================================================
%  OBIETTIVO:
%  1. Identificare un sistema dinamico non lineare (NARX).
%  2. Costruire i regressori (input ritardati) per la rete.
%  3. Confrontare le prestazioni in Predizione (1-step) vs Simulazione (Loop).
%  [Rif. Teoria: Reti Neurali per sistemi dinamici, NARX]
%  ==============================================================

clear all
close all
clc

%% 1. Generazione Dati (Sistema Dinamico)
% Sistema: y(k) = g(y(k-1), y(k-2)) + u(k)
% La funzione g(.) è definita nel file 'nonlinDE.m'

N = 400;

% Creiamo un ingresso ricco (combinazione random + sinusoide)
u1 = 3 * (rand(1, N/2) - 0.5);      % Parte Random
u2 = sin(2*pi * ((N/2+1):N) / 25);  % Parte Sinusoidale
u = [u1 u2];

% Simulazione del sistema vero
y = zeros(1, N);
% Primi due passi inizializzati (perché servono k-1 e k-2)
y(1:2) = u(1:2); 

for k = 3:N
    % Equazione alle differenze non lineare
    y(k) = nonlinDE(y(k-1), y(k-2)) + u(k);
end

figure(1)
subplot(2,1,1); plot(u); title('Ingresso Training');
subplot(2,1,2); plot(y); title('Uscita Training');

%% 2. Preparazione Dati per la Rete (Regressori)
% La rete è statica: Input -> Output.
% Dobbiamo trasformare il problema dinamico in uno statico mappando:
% [y(k-1); y(k-2); u(k)]  --->  [y(k)]

% Creiamo la matrice degli input per il training (3 righe x N colonne)
TrainInput = zeros(3, N);
TrainInput(1, :) = [0, y(1:end-1)];     % Regressore y(k-1)
TrainInput(2, :) = [0, 0, y(1:end-2)];  % Regressore y(k-2)
TrainInput(3, :) = u;                   % Regressore u(k)

TrainOutput = y;

%% 3. Creazione e Training della Rete
% Rete con 2 strati nascosti da 5 neuroni ciascuno
net = feedforwardnet([5 5]); 
net.trainParam.showWindow = false;

fprintf('Addestramento Rete Dinamica...\n');
[net, TR] = train(net, TrainInput, TrainOutput);

%% 4. Validazione: Predizione vs Simulazione
% Generiamo un NUOVO set di dati (Validazione) usando APRBS
N_val = 400;
U_val = aprbs(N_val, 1, 20, -1.5, 1.5);

Y_val = zeros(1, N_val);
Y_val(1:2) = U_val(1:2);
for k = 3:N_val
    Y_val(k) = nonlinDE(Y_val(k-1), Y_val(k-2)) + U_val(k);
end

% --- CASO A: Predizione (One-Step Ahead) ---
% La rete usa i dati VERI del passato per predire il futuro.
PredInput = zeros(3, N_val);
PredInput(1, :) = [0, Y_val(1:end-1)];
PredInput(2, :) = [0, 0, Y_val(1:end-2)];
PredInput(3, :) = U_val;

Y_pred = sim(net, PredInput);
Err_pred = Y_val - Y_pred;

% --- CASO B: Simulazione (Model Output) ---
% La rete usa le SUE STESSE uscite passate. È un loop chiuso.
% Questo è il vero test per vedere se il modello è stabile autonomamente.
Y_sim = zeros(1, N_val);
Y_sim(1:2) = Y_val(1:2); % Condizioni iniziali

for k = 3:N_val
    % Costruiamo il vettore di input al volo usando le stime passate
    input_k = [Y_sim(k-1); Y_sim(k-2); U_val(k)];
    Y_sim(k) = sim(net, input_k);
end
Err_sim = Y_val - Y_sim;

%% 5. Visualizzazione Confronto
figure(2)
subplot(2,1,1)
plot(Y_val, 'k', 'LineWidth', 1); hold on;
plot(Y_pred, 'b--');
plot(Y_sim, 'r-.', 'LineWidth', 1.5);
legend('Sistema Vero', 'Predizione (1-step)', 'Simulazione (Ricorsiva)');
title('Confronto Dinamico su Dati di Validazione');

subplot(2,1,2)
plot(Err_pred, 'b'); hold on;
plot(Err_sim, 'r');
legend('Errore Predizione', 'Errore Simulazione');
title('Errori Residui');
grid on;

% NOTA: L'errore di simulazione (Rosso) è solitamente maggiore di quello
% di predizione (Blu) perché gli errori si accumulano nel tempo.