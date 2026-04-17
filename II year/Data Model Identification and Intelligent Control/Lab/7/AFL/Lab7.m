%% LAB 7: Adaptive Feedback Linearization (Sistema 1° Ordine)
%  ==============================================================

clear all
close all
clc

%% 1. INIZIALIZZAZIONE PARAMETRI (Legacy Mode)
%  Definiamo le variabili esattamente come vuole il Simulink.

% --- Parametri Generali ---
T_sim = 100;    % Durata simulazione
Ts    = 0.01;   % Passo di campionamento
x0    = -1;     % Condizione iniziale

% --- Parametri Rete Neurale (RBF) ---
% Centri delle Gaussiane (Definiti scalarmente come richiesto dai blocchi)
c1 = -1;
c2 = -0.5;
c3 = 0;
c4 = 0.5;
c5 = 1;

% Larghezze delle Gaussiane (Spread)
s_val = 0.5; % Valore comune (0.25 * 2 come nel file originale)
s1 = s_val;
s2 = s_val;
s3 = s_val;
s4 = s_val;
s5 = s_val;

% --- Parametri di Adattamento (Learning Rates) ---
gamma_f = 100;   % Velocità apprendimento f(x) (Originale: 50*0.2)
gamma_g = 10;    % Velocità apprendimento g(x) (Originale: 10*0.2)

% --- Condizioni Iniziali Pesi (Theta) ---
% Vettori colonna 5x1 (poiché abbiamo 5 neuroni)
Teta_f0 = zeros(5, 1);
Teta_g0 = ones(5, 1)*0.5;  % Importante: diverso da 0 per evitare divisioni per zero!

% --- Coefficienti di Normalizzazione (Gain) ---
% Queste sono le variabili che davano errore "Unrecognized variable"
C = 40;     % Guadagno di normalizzazione 1
G = 1/20;   % Guadagno di normalizzazione 2

% Parametro lambda (polo errore), se richiesto dal controllore
lambda = 1;

fprintf('Parametri caricati.\n');

%% 2. VISUALIZZAZIONE RBF (ex plotta_RBF.m)
%  Vediamo come sono fatte le "basi" della nostra rete neurale.

figure(1)
u_plot = -2:0.01:2; % Range esteso per vedere bene le campane
y1 = exp((-(u_plot-c1).^2)./(s1^2));
y2 = exp((-(u_plot-c2).^2)./(s2^2));
y3 = exp((-(u_plot-c3).^2)./(s3^2));
y4 = exp((-(u_plot-c4).^2)./(s4^2));
y5 = exp((-(u_plot-c5).^2)./(s5^2));

plot(u_plot, y1, u_plot, y2, u_plot, y3, u_plot, y4, u_plot, y5);
title('Funzioni di Base Radiale (RBF)');
xlabel('Input della rete (Stato x)');
grid on;

%% 3. SIMULAZIONE
%  Scegli qui quale modello eseguire commentando/scommentando

mdl_name = 'esempio1_farrell';
% mdl_name = 'esempio1_farrell_PI'; 

if ~exist([mdl_name '.mdl'], 'file')
    error('File modello non trovato!');
end

% Carica e configura
load_system(mdl_name);
set_param(mdl_name, 'StopTime', num2str(T_sim));
set_param(mdl_name, 'ReturnWorkspaceOutputs', 'off'); % Niente 'out'
set_param(mdl_name, 'SignalLogging', 'on');          % Attiva logsout come backup
set_param(mdl_name, 'SignalLoggingName', 'logsout');

fprintf('Avvio simulazione di %s...\n', mdl_name);
sim(mdl_name);
fprintf('Simulazione completata.\n');

%% 4. RECUPERO DATI DAL WORKSPACE
%  Qui sta il trucco: cerchiamo le variabili "libere" nel workspace.

% A) Cerchiamo il Tempo
if exist('tout', 'var')
    T = tout;
else
    T = (0:Ts:T_sim)'; % Fallback
end

% B) Cerchiamo i Segnali (Funzione helper in fondo al file)
% Cerca 'x', se non c'è cerca in 'logsout', se no restituisce vuoto.
x_data  = get_from_workspace('x', 'logsout');
xm_data = get_from_workspace('xm', 'logsout');
f_hat   = get_from_workspace('f_hat', 'logsout');
g_hat   = get_from_workspace('g_hat', 'logsout');

%% 5. ANALISI GRAFICA

% --- Figura 1: Tracking ---
figure(2); clf;
set(gcf, 'Name', 'Tracking');

subplot(2,1,1);
if ~isempty(x_data) && ~isempty(xm_data)
    % Gestione lunghezze vettori (talvolta differiscono di 1 campione)
    L = min([length(T), length(x_data), length(xm_data)]);
    plot(T(1:L), xm_data(1:L), 'r--', 'LineWidth', 2); hold on;
    plot(T(1:L), x_data(1:L), 'b', 'LineWidth', 1.5);
    legend('Riferimento (y_d)', 'Uscita (y)');
    title('Tracking'); grid on; axis tight;
    
    subplot(2,1,2);
    plot(T(1:L), xm_data(1:L) - x_data(1:L), 'k');
    title('Errore'); grid on; axis tight;
else
    text(0.5, 0.5, 'Dati x o xm NON TROVATI nel Workspace', 'HorizontalAlignment', 'center');
end

% --- Figura 2: Stima Funzioni ---
% Ricostruzione Curve Teoriche (dal file plotta_f_e_g.m)
xx = -2:0.01:2;
f_teorica = -1 - 0.01 * xx.^2;
g_teorica = (C * (xx + 1)) ./ (C + xx);

figure(3); clf;
set(gcf, 'Name', 'Stima f e g');

% Plot f(x)
subplot(2,1,1)
plot(xx, f_teorica, 'c', 'LineWidth', 2); hold on;
if ~isempty(f_hat) && ~isempty(x_data)
    L = min([length(x_data), length(f_hat)]);
    plot(x_data(1:L), f_hat(1:L), 'b.', 'MarkerSize', 2);
    legend('f(x) Teorica', 'f(x) Stimata');
end
title('Stima f(x)'); grid on; axis([-1.5 1.5 -2 0]);

% Plot g(x)
subplot(2,1,2)
plot(xx, g_teorica, 'c', 'LineWidth', 2); hold on;
if ~isempty(g_hat) && ~isempty(x_data)
    L = min([length(x_data), length(g_hat)]);
    plot(x_data(1:L), g_hat(1:L), 'r.', 'MarkerSize', 2);
    legend('g(x) Teorica', 'g(x) Stimata');
end
title('Stima g(x)'); grid on; axis([-1.5 1.5 0.5 1.5]);


%% --- FUNZIONE RECUPERO DATI ---
function val = get_from_workspace(var_name, log_name)
    val = [];
    
    % 1. Cerca variabile diretta nel Workspace (es. x)
    try
        raw = evalin('base', var_name);
        % Se è una struct (es. x.time, x.signals.values)
        if isstruct(raw) && isfield(raw, 'signals')
            val = raw.signals.values;
            return;
        elseif isa(raw, 'timeseries')
            val = raw.Data;
            return;
        elseif isnumeric(raw)
            val = raw;
            return;
        end
    catch
        % Variabile non trovata, continua...
    end
    
    % 2. Cerca dentro logsout (se esiste nel base workspace)
    try
        logs = evalin('base', log_name);
        if isa(logs, 'Simulink.SimulationData.Dataset')
            elem = logs.find(var_name);
            if ~isempty(elem)
                if iscell(elem), elem = elem{1}; end
                val = elem.Values.Data;
                return;
            end
        end
    catch
    end
end

%% ESERCIZIO
% Prova a cambiare i parametri c1..c5 per coprire un range più ampio
% (es. da -2 a 2) e vedi se il tracking migliora quando il segnale è ampio.