%% INIZIO SEZIONE QUI
clc;
clear all;
close all;

% --- PARAMETRI SISTEMA E SIMULAZIONE (Domanda B) ---
Tf = 10;           % Durata simulazione
Ts = 0.5;          % Sampling time (Dato dalla traccia)
Hp = 12;           % Prediction Horizon
Hc = 5;            % Control Horizon
t = 0:Ts:Tf;

% Target da raggiungere (Parcheggio)
% Esempio: Spostarsi a x=10, y=10, allineati a 90 gradi
ref = [10, 10, deg2rad(90), deg2rad(90)]; 

% Stop Condition (Domanda D)
epsilon_pos = 1.0;      % Errore posizione < 1m
epsilon_angle = deg2rad(1); % Errore angolo < 1 deg

% --- COSTRUZIONE CONTROLLER NLMPC ---
% 4 Stati (x,y,theta,beta), 4 Uscite (x,y,theta,beta), 2 Ingressi (v, alpha)
mpcobj = nlmpc(4, 4, 2);

% Assegnazione Orizzonti e Tempo
mpcobj.Ts = Ts;
mpcobj.PredictionHorizon = Hp;
mpcobj.ControlHorizon = Hc;

% Collegamento Funzioni (Modello e Jacobiani)
mpcobj.Model.StateFcn = 'stateFCN';
mpcobj.Model.OutputFcn = 'outputFCN'; 
mpcobj.Jacobian.StateFcn = 'jacStateFCN'; 

mpcobj.Model.NumberOfParameters = 1; % Passiamo Ts come parametro

% --- VINCOLI (Domanda C) ---
% "Steering angle alpha range +-45 deg"
mpcobj.ManipulatedVariables(2).Min = deg2rad(-45);
mpcobj.ManipulatedVariables(2).Max = deg2rad(45);

% "Max forward speed 10, reverse 10" -> [-10, 10]
mpcobj.ManipulatedVariables(1).Min = -10;
mpcobj.ManipulatedVariables(1).Max = 10;

% "Angle between truck and trailer (beta) cannot go beyond +-90"
% Questo è un vincolo di STATO (Output Constraint perché y=x)
mpcobj.OutputVariables(4).Min = deg2rad(-90);
mpcobj.OutputVariables(4).Max = deg2rad(90);
% Rendiamolo HARD CONSTRAINT (Domanda C chiede se ha effetto)
mpcobj.OutputVariables(4).MinECR = 0;
mpcobj.OutputVariables(4).MaxECR = 0;

% % --- TUNING (Domanda D) ---
% % Obiettivo: Tempo < 6s, errore piccolo. Serve aggressività.
% % Pesi sulle uscite (Tracking)
% mpcobj.Weights.OutputVariables = [10 10 5 5]; % Priorità alta a X e Y
% 
% % Pesi sugli ingressi (Sforzo)
% mpcobj.Weights.ManipulatedVariables = [0.1 0.1]; % Costo basso per usare molto "gas"
% 
% % Pesi sui Rate (Dolcezza)
% % Se vogliamo velocità, riduciamo questi pesi per permettere scatti rapidi
% mpcobj.Weights.ManipulatedVariablesRate = [0.1 0.1]; 

%% --- TUNING (SELETTORE CASO 1 vs CASO 2) ---
% Imposta questa variabile a 1 o 2 per vedere la differenza
CASO = 2; 

if CASO == 1
    % === CASO 1: TUNING STANDARD (Domanda B/C) ===
    % Comportamento: Movimento dolce, ma lento.
    % Nota: Nel PDF si vede che arriva a destinazione lentamente.
    
    disp('Simulazione CASO 1: Tuning Standard (Lento)');
    
    % Pesi bassi sull'errore di tracking (si accontenta di arrivare piano)
    mpcobj.Weights.OutputVariables = [1 1 1 1]; 
    
    % Pesi standard sugli ingressi (non vuole consumare troppo)
    mpcobj.Weights.ManipulatedVariables = [0.1 0.1];
    
    % Pesi sulla variazione degli ingressi (vuole sterzate dolci)
    mpcobj.Weights.ManipulatedVariablesRate = [0.1 0.1]; 

elseif CASO == 2
    % === CASO 2: TUNING AGGRESSIVO (Domanda D) ===
    % Obiettivo: Tempo < 6s.
    % Soluzione PDF: "Raddoppiamo i pesi sulle uscite", "Rendiamo l'azione aggressiva"
    
    disp('Simulazione CASO 2: Tuning Aggressivo (Veloce)');
    
    % Pesi MOLTO ALTI sull'errore (x,y). 
    % Significa: "Per ogni metro di errore, paghi una multa salatissima".
    % Il controller correrà per ridurre questo costo.
    mpcobj.Weights.OutputVariables = [10 10 5 5]; 
    
    % Pesi bassi sugli ingressi.
    % Significa: "Il gas è gratis, usalo tutto pur di arrivare presto".
    mpcobj.Weights.ManipulatedVariables = [0.05 0.05]; 
    
    % Pesi bassi sui Rate.
    % Significa: "Puoi sterzare bruscamente se serve".
    mpcobj.Weights.ManipulatedVariablesRate = [0.05 0.05]; 
end

% --- VALIDAZIONE ---
options = nlmpcmoveopt;
options.Parameters = {Ts};
validateFcns(mpcobj, rand(4,1), rand(2,1), [], options.Parameters);

%% SIMULAZIONE
% Inizializzazione
x0 = [0; 0; 0; 0]; % Partenza dall'origine
xk = x0;
mv = [0; 0];

% u_history = [];
% x_history = [];
% y_history = [];
% time_history = [];

fprintf('Avvio simulazione MPC Truck-Trailer...\n');

% --- Inizializzazione Vettori Storia ---
u_history = [];
x_history = [x0']; % Salva stato iniziale
y_history = [x0']; % Salva uscita iniziale (y=x)
J_history = [];    % Per la funzione di costo
time_history = []; % Per il tempo di calcolo

fprintf('Avvio simulazione MPC...\n');

for k=1:length(t)
    % Start Timer
    tic; 
    
    [mv, opt, info] = nlmpcmove(mpcobj, xk, mv, ref, [], options);
    
    % Stop Timer e salvataggio
    cal_time = toc; 
    time_history = [time_history; cal_time];
    
    % Salvataggio Costo (Domanda F)
    % A volte info.Cost può essere vuoto al primo step, gestiamo l'eccezione
    if isfield(info, 'Cost') && ~isempty(info.Cost)
        J_history = [J_history; info.Cost];
    else
        J_history = [J_history; 0]; % Fallback se non disponibile
    end
    
    % Aggiornamento Stato
    xk = info.Xopt(2,:)';
    y = xk; 
    
    % Salvataggio Storia
    u_history = [u_history; mv'];
    x_history = [x_history; xk'];
    y_history = [y_history; y'];
    
    % Stop Condition (opzionale)
    % if ... break; end
end

%% PLOTTING CORRETTO E COMPLETO

% Creiamo vettori temporali coerenti con i dati salvati
% t_steps: per vettori lunghi quanto il loop (Cost, Time, Input)
len_sim = length(J_history); 

% Tempo per gli ingressi e Costo (lunghezza N)
t_steps = 0:Ts:(size(u_history,1)-1)*Ts;

% Tempo per gli Stati (lunghezza N+1 perché c'è lo stato iniziale x0)
t_states = 0:Ts:(size(x_history,1)-1)*Ts;

% --- FIGURA 1: Ingressi (Stile Traccia) ---
figure(1);
subplot(2,1,1);
stairs(t_steps, u_history(1:len_sim,1), 'LineWidth', 1.5);
ylabel('v [m/s]'); grid on; title('Ingresso: Velocità v');
yline(10, 'r--'); yline(-10, 'r--'); % Vincoli

subplot(2,1,2);
stairs(t_steps, rad2deg(u_history(1:len_sim,2)), 'LineWidth', 1.5);
ylabel('\alpha [deg]'); grid on; title('Ingresso: Sterzo \alpha');
yline(45, 'r--'); yline(-45, 'r--'); % Vincoli


% --- FIGURA 2: Stati (4 Subplot impilati verticalmente) ---
figure(2);
sgtitle('Evoluzione degli Stati'); 

% x1: Posizione X
subplot(4,1,1);
plot(t_states, x_history(:,1), 'LineWidth', 1.5);
ylabel('x [m]'); grid on; 
title('x_1 (Posizione X)');

% x2: Posizione Y
subplot(4,1,2);
plot(t_states, x_history(:,2), 'LineWidth', 1.5);
ylabel('y [m]'); grid on; 
title('x_2 (Posizione Y)');

% x3: Angolo Truck
subplot(4,1,3);
plot(t_states, rad2deg(x_history(:,3)), 'LineWidth', 1.5);
ylabel('\theta [deg]'); grid on; 
title('x_3 (Angolo Truck \theta)');

% x4: Angolo Trailer
subplot(4,1,4);
plot(t_states, rad2deg(x_history(:,4)), 'LineWidth', 1.5);
ylabel('\beta [deg]'); xlabel('Time [s]'); grid on; 
title('x_4 (Angolo Trailer \beta)');
yline(90, 'r--'); yline(-90, 'r--'); 


% --- FIGURA 3: Traiettoria XY (Domanda F - fig 4 suggestion) ---
figure(3);
plot(x_history(:,1), x_history(:,2), 'b-o', 'LineWidth', 1.5); hold on;
plot(ref(1), ref(2), 'rx', 'MarkerSize', 12, 'LineWidth', 2);
title('Traiettoria nel Piano XY');
xlabel('X [m]'); ylabel('Y [m]');
grid on; axis equal;


% --- FIGURA 4: Funzione di Costo (Domanda F) ---
figure(4);
plot(t_steps, J_history, 'c-', 'LineWidth', 2);
title('Andamento Funzione di Costo J(k)');
xlabel('Time [s]'); ylabel('Cost Value');
grid on;
% Nota: Se il valore è molto alto all'inizio, usa: set(gca, 'YScale', 'log')


% --- FIGURA 5: Tempo Computazionale (Domanda E) ---
figure(5);
plot(t_steps, time_history, 'm-', 'LineWidth', 1.5);
hold on;
yline(Ts, 'r--', 'LineWidth', 2); % Linea rossa limite Ts
title('Tempo Computazionale per Passo');
xlabel('Time [s]'); ylabel('Calc Time [s]');
legend('Tempo Calcolo', 'Ts (Limite Real-Time)');
grid on;

if max(time_history) < Ts
    disp('RESA: Il sistema è controllabile in Real-Time (Max Time < Ts)');
else
    disp('ATTENZIONE: Il sistema NON è Real-Time (Violazione Ts rilevata)');
end