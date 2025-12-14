%% SETUP INIZIALE
clc; 
clear all; 
close all;

% Parametri Simulazione (Domanda B)
Ts = 0.1;           % Time step
Tf = 10;            % Durata
Hp = 10;            % Prediction Horizon
Hc = 2;             % Control Horizon
t = 0:Ts:Tf;

% Riferimento Statico (Dato dalla traccia)
% Target: P=1, Q=0, H=7
ref = [1, 0, 7]; 

% Condizioni Iniziali
x0 = [0; 0; 5]; 

%% CONFIGURAZIONE NLMPC
% 3 Stati (P,Q,H), 3 Uscite (y=x), 2 Ingressi (uP, uQ)
nx = 3;
ny = 3;
nu = 2;
mpcobj = nlmpc(nx, ny, nu);

mpcobj.Ts = Ts;
mpcobj.PredictionHorizon = Hp;
mpcobj.ControlHorizon = Hc;

% Collegamento Funzioni
mpcobj.Model.StateFcn = 'stateFCN';
mpcobj.Jacobian.StateFcn = 'jacStateFCN';
mpcobj.Model.OutputFcn = 'outputFCN';
mpcobj.Jacobian.OutputFcn = 'jacOutputFCN';

% Parametri
mpcobj.Model.NumberOfParameters = 1; % Passiamo Ts

%% VINCOLI (Domanda C)
% "Pressure at inflow (uP) bounded between [-1000, 1000]"
% u(1) è uP
mpcobj.ManipulatedVariables(1).Min = -1000;
mpcobj.ManipulatedVariables(1).Max = 1000;
mpcobj.ManipulatedVariables(1).MinECR = 0; % Hard Constraint
mpcobj.ManipulatedVariables(1).MaxECR = 0;

% Non ci sono vincoli espliciti su uQ (u2), ma è buona norma metterne
% se sono valvole (es. 0-100) o lasciare libero se ideale.

%% TUNING (Pesi)
% Obiettivo: Raggiungere P=1, Q=0, H=7.
% H è solitamente la variabile più lenta e critica (livello serbatoio).
mpcobj.Weights.OutputVariables = [1 1 10]; % Peso maggiore su H
mpcobj.Weights.ManipulatedVariables = [0.1 0.1]; % Peso basso sugli ingressi
mpcobj.Weights.ManipulatedVariablesRate = [0.1 0.1];

%% VALIDAZIONE
options = nlmpcmoveopt;
options.Parameters = {Ts};
validateFcns(mpcobj, x0, [0;0], [], options.Parameters);

%% SIMULAZIONE
xk = x0; % Imposta lo stato attuale (k) uguale allo stato iniziale
mv = [0;0]; % Imposta l'ultimo ingresso applicato a zero (partiamo da fermi)

% Storici
x_history = [x0'];
u_history = [];
J_history = [];
time_history = [];

for k=1:length(t)
    tic; % AVVIA IL CRONOMETRO (Start)
    [mv, opt, info] = nlmpcmove(mpcobj, xk, mv, ref, [], options);
    time_history = [time_history; toc]; % FERMA IL CRONOMETRO (Stop) e salva il tempo
    
    % Aggiornamento stato
    xk = info.Xopt(2,:)';
    
    % Salvataggio
    u_history = [u_history; mv'];
    x_history = [x_history; xk'];
    J_history = [J_history; info.Cost];
end

%% PLOTTING
t_steps = 0:Ts:(size(u_history,1)-1)*Ts;
t_states = 0:Ts:(size(x_history,1)-1)*Ts;

% --- Figura 1: Stati ---
figure(1);
subplot(3,1,1); plot(t_states, x_history(:,1)); ylabel('P'); grid on; title('Pressione');
yline(ref(1), 'r--');
subplot(3,1,2); plot(t_states, x_history(:,2)); ylabel('Q'); grid on; title('Portata');
yline(ref(2), 'r--');
subplot(3,1,3); plot(t_states, x_history(:,3)); ylabel('H'); grid on; title('Livello');
yline(ref(3), 'r--');

% --- Figura 2: Ingressi ---
figure(2);
subplot(2,1,1); stairs(t_steps, u_history(:,1)); ylabel('u_P'); grid on; title('Input Pressione');
yline(1000, 'r--'); yline(-1000, 'r--'); % Limiti
subplot(2,1,2); stairs(t_steps, u_history(:,2)); ylabel('u_Q'); grid on; title('Input Portata');


% --- RISPOSTA E: Computational Time ---
figure(3);
plot(0:Ts:(length(time_history)-1)*Ts, time_history, 'g-', 'LineWidth', 1.5);
hold on;
yline(Ts, 'r--', 'LineWidth', 2); % Linea rossa del limite Ts
title('Tempo Computazionale per Passo');
xlabel('Tempo simulazione [s]');
ylabel('Tempo Calcolo [s]');
legend('Tempo impiegato', 'Limite Ts');
grid on;

% % Calcolo automatico per la risposta
% max_time = max(time_history);
% if max_time < Ts
%     disp(['RISPOSTA E: SI. Max Time (' num2str(max_time) 's) < Ts (' num2str(Ts) 's).']);
% else
%     disp(['RISPOSTA E: NO. Max Time (' num2str(max_time) 's) > Ts.']);
% end

% Il sistema reale evolverebbe prima che tu abbia deciso cosa fare. 
% Non è fattibile in Real-Time (su questo PC).

% --- RISPOSTA F: Cost Function ---
figure(4);
plot(0:Ts:(length(J_history)-1)*Ts, J_history, 'c-', 'LineWidth', 2);
title('Evoluzione Funzione di Costo V(k)');
xlabel('Tempo simulazione [s]');
ylabel('Valore Costo');
grid on;
% Se il valore iniziale è altissimo, usa la scala logaritmica per vedere meglio:
% set(gca, 'YScale', 'log');


% -- Risposta D ---
%Il sistema in anello chiuso risulta INSTABILE. 
% La pressione diverge (raggiunge 200 bar) e la funzione di costo cresce 
% esponenzialmente invece di decrescere. 
% Ciò indica un errore nella modellazione o un
% tuning dei pesi troppo aggressivo per il passo di campionamento scelto.