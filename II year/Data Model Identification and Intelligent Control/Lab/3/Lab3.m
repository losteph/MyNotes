%% LAB 3: Polarizzazione dello Stimatore (Bias)
%  ==============================================================
%  OBIETTIVO:
%  Dimostrare l'effetto della scelta errata della famiglia di modelli.
%  Confrontiamo:
%  1. Caso CORRETTO: MGD ARX -> Identificazione ARX
%  2. Caso POLARIZZATO: MGD ARMAX -> Identificazione ARX
%
%  Si dimostra che nel caso 2 l'errore non va a zero asintoticamente.
%  ==============================================================

clear
close all
clc

%% 1. Configurazione Esperimento Monte Carlo

Num_Exp = 20;   % Numero di esperimenti su cui fare la media
N_steps = [50 100 200 500 9000]; % Step di dati crescenti
NoiseVar = 1e-3; % Rumore significativo per vedere l'effetto del Bias
Ts = 0.01;

% Parametri Veri
A = [1 -2.61 2.49 -1.02 0.15];
B = [0 -0.02 -0.03 0.05 0.01];
C = [1 1.9 0.4]; % Presente solo nel sistema ARMAX

% Inizializzazione vettori accumulo errori
Errors_Polarized = zeros(Num_Exp, length(N_steps)); % Caso Sbagliato
Errors_Consistent = zeros(Num_Exp, length(N_steps)); % Caso Giusto

fprintf('Avvio Simulazione Monte Carlo (%d iterazioni)...\n', Num_Exp);

%% 2. Loop Monte Carlo

for k = 1:Num_Exp
    
    % Generazione Input/Rumore nuovi per ogni esperimento
    U = randn(10000, 1);
    
    % --- SCENARIO A: POLARIZZAZIONE (MGD = ARMAX, Modello = ARX) ---
    % Il sistema vero ha C diverso da 1
    S_armax = idpoly(A, B, C, [], [], NoiseVar, Ts);
    Y_bias  = sim(S_armax, U, 'Noise');
    Data_bias = iddata(Y_bias, U, Ts);
    
    % --- SCENARIO B: CONSISTENZA (MGD = ARX, Modello = ARX) ---
    % Il sistema vero ha C = 1 (implicito in idpoly se non specificato)
    S_arx = idpoly(A, B, [], [], [], NoiseVar, Ts);
    Y_ok  = sim(S_arx, U, 'Noise');
    Data_ok = iddata(Y_ok, U, Ts);
    
    % Identificazione su N crescente
    for i = 1:length(N_steps)
        N = N_steps(i);
        
        % 1. Stima Polarizzata (ARX su dati ARMAX)
        m_bad = arx(Data_bias(1:N), [4 4 1]);
        [B_bad, A_bad] = tfdata(m_bad, 'v');
        % Calcolo errore quadratico totale
        Errors_Polarized(k, i) = sqrt(sum((A - A_bad).^2) + sum((B - B_bad).^2));
        
        % 2. Stima Consistente (ARX su dati ARX)
        m_good = arx(Data_ok(1:N), [4 4 1]);
        [B_good, A_good] = tfdata(m_good, 'v');
        Errors_Consistent(k, i) = sqrt(sum((A - A_good).^2) + sum((B - B_good).^2));
    end
end

%% 3. Calcolo Medie e Plot

% Media degli errori su tutti gli esperimenti
Avg_Err_Polarized = mean(Errors_Polarized);
Avg_Err_Consistent = mean(Errors_Consistent);

figure(1)
% Plot Caso Polarizzato (Rosso)
semilogx(N_steps, Avg_Err_Polarized, '-ro', 'LineWidth', 2); hold on;
% Plot Caso Consistente (Blu)
semilogx(N_steps, Avg_Err_Consistent, '-b*', 'LineWidth', 2);

grid on
xlabel('Numero di Dati (N)');
ylabel('Errore Quadratico Medio Parametri');
legend('MGD ARMAX (Stima ARX -> Polarizzata)', 'MGD ARX (Stima ARX -> Consistente)');
title('Effetto della Polarizzazione (Bias)');

% Nota didattica:
% Osserva come la linea BLU scende verso lo zero al crescere di N.
% La linea ROSSA scende inizialmente (riduzione varianza) ma si ferma 
% su un asintoto > 0 (il Bias strutturale).