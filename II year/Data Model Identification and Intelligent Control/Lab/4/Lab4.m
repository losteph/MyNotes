%% LAB 4: Scelta dell'Ordine Ottimo (AIC, MDL, FPE)
%  ==============================================================
%  OBIETTIVO:
%  Determinare l'ordine corretto di un modello analizzando l'andamento
%  delle funzioni di costo (Loss Functions) e degli indici statistici
%  (AIC, FPE, MDL) al variare della complessità del modello.
%  [Rif. Teoria: Paragrafo 5.3 - Ordine Ottimo di un Modello]
%  ==============================================================

clear 
close all
clc

%% 1. Generazione Dati (MGD con Rumore Colorato)
% Costruiamo un sistema dove il rumore NON è bianco, ma colorato.
% Questo rende difficile per un modello ARX trovare l'ordine "vero",
% costringendoci a cercare il miglior compromesso.

N = 1000;
U = idinput(N, 'rbs', [0 0.5]); % Random Binary Sequence

% Sistema "Vero" (Deterministico)
A_true = [1.00 -2.61  2.49 -1.02 0.15];
B_true = [0    -0.02 -0.03  0.05 0.01];
S_true = idpoly(A_true, B_true, [], [], [], 0, 1);
Y_clean = sim(S_true, U);

% Aggiunta Rumore Colorato (Simulazione di un disturbo realistico)
% Creiamo un rumore filtrato (bassa frequenza)
e = randn(N, 1);
v = filter(1, [1 -0.9], e); % Filtro passa-basso sul rumore

% Regoliamo il rapporto segnale/rumore (SNR)
% noise_level determina quanto è "forte" il disturbo rispetto all'uscita
noise_level = 0.1; % 10% di rumore (cambiare a 0.01 o 0.5 per esperimenti)
v_scaled = (v / std(v)) * sqrt(noise_level) * std(Y_clean);
Y = Y_clean + v_scaled;

Data = iddata(Y, U, 1);

%% 2. Suddivisione Training e Validation
% È cruciale usare dati diversi per calcolare AIC/MDL e per validare.

N_train = 500;
TrainData = Data(1:N_train);
ValidData = Data(N_train+1:end);

%% 3. Ciclo di Identificazione su Ordini Crescenti
% Testiamo modelli ARX di ordine k = 1, 2, ..., 30
% Struttura testata: ARX [k, k, 1]

Max_Order = 20; 

% Inizializzazione vettori metriche
J_pred_train = zeros(Max_Order, 1);
J_pred_valid = zeros(Max_Order, 1);
J_sim_valid  = zeros(Max_Order, 1);

FPE_idx = zeros(Max_Order, 1); % Final Prediction Error
AIC_idx = zeros(Max_Order, 1); % Akaike Information Criterion
MDL_idx = zeros(Max_Order, 1); % Minimum Description Length

fprintf('Avvio scansione ordini...\n');

for k = 1:Max_Order
    
    % 1. Stima modello ARX di ordine k
    m = arx(TrainData, [k k 1]);
    
    % 2. Calcolo Errore di Predizione (loss function J)
    % J = covarianza dell'errore epsilon
    pe_train = pe(m, TrainData); 
    J_pred_train(k) = cov(pe_train.OutputData);
    
    pe_valid = pe(m, ValidData);
    J_pred_valid(k) = cov(pe_valid.OutputData);
    
    % 3. Calcolo Errore in Simulazione (più severo)
    y_sim_val = sim(m, ValidData.U);
    err_sim = ValidData.Y - y_sim_val;
    J_sim_valid(k) = cov(err_sim);
    
    % 4. Calcolo Indici di Ottimalità (Teoria pag. 21)
    % n_params = numero totale parametri (na + nb)
    n_params = 2 * k; 
    N_samples = N_train;
    Loss = J_pred_train(k); % Loss sui dati di stima
    
    % FPE (Akaike Final Prediction Error)
    FPE_idx(k) = Loss * (N_samples + n_params) / (N_samples - n_params);
    
    % AIC (Akaike Information Criterion)
    AIC_idx(k) = log(Loss) + 2 * n_params / N_samples;
    
    % MDL (Minimum Description Length) - Penalizza di più la complessità
    MDL_idx(k) = log(Loss) + n_params * log(N_samples) / N_samples;
    
end

%% 4. Visualizzazione Risultati

x_axis = 1:Max_Order;

% FIGURA 1: Training vs Validation (Il concetto di Overfitting)
figure(1)
subplot(2,1,1)
plot(x_axis, J_pred_train, '-b', x_axis, J_pred_valid, '-r', 'LineWidth', 2);
title('Loss Function: Training (Blu) vs Validation (Rosso)');
legend('Training J', 'Validation J');
grid on;
ylabel('Errore Predizione');

subplot(2,1,2)
plot(x_axis, J_sim_valid, '-g', 'LineWidth', 2);
title('Loss Function in Simulazione (Validation)');
xlabel('Ordine del Modello (k)');
grid on;

% FIGURA 2: Indici di Ottimalità (Dove sta il minimo?)
figure(2)
subplot(3,1,1); plot(x_axis, FPE_idx, '-o'); title('FPE (Final Prediction Error)'); grid on;
subplot(3,1,2); plot(x_axis, AIC_idx, '-o'); title('AIC (Akaike)'); grid on;
subplot(3,1,3); plot(x_axis, MDL_idx, '-o'); title('MDL (Min Description Length)'); grid on;
xlabel('Ordine del Modello (k)');

% Trova i minimi
[~, best_aic] = min(AIC_idx);
[~, best_mdl] = min(MDL_idx);
fprintf('\n--- RISULTATI OTTIMIZZAZIONE ---\n');
fprintf('Ordine ottimo secondo AIC: %d\n', best_aic);
fprintf('Ordine ottimo secondo MDL: %d\n', best_mdl

%% APPENDICE: Gestione Manuale dei Dati (Save/Load)
%  ==============================================================
%  NOTA PER L'ESAME:
%  Spesso la generazione dati (MGD) e l'identificazione sono separate.
%  Ecco come gestire il salvataggio e caricamento manuale.
%  ==============================================================

% --- SCENARIO A: Sei tu a generare i dati e devi salvarli ---
% Supponiamo tu abbia generato varie condizioni di rumore:
% data_clean = iddata(Y_clean, U, Ts);
% data_noisy = iddata(Y_noisy, U, Ts);

% Per salvare tutto il Workspace in un file:
% save('MieiDatiEsame.mat'); 

% Per salvare SOLO specifiche variabili (Consigliato per pulizia):
% Sintassi: save('NomeFile.mat', 'var1', 'var2', ...)
% save('Dati_Lab4.mat', 'data_clean', 'data_noisy', 'A_true', 'B_true');

% ------------------------------------------------------------

% --- SCENARIO B: Il prof ti da un file e devi caricarlo ---
% All'inizio dello script di analisi, invece di generare U e Y:

% 1. Pulisci la memoria
% clear all; 

% 2. Carica il file (assicurati che sia nella Current Folder)
% load('Dati_Lab4.mat');

% 3. Ora nel Workspace hai le variabili pronte (es. 'data_noisy')
% Puoi verificare cosa c'è dentro con il comando:
% whos

% Esempio di utilizzo dopo il load:
% train = data_noisy(1:300);
% m = arx(train, [2 2 1]);