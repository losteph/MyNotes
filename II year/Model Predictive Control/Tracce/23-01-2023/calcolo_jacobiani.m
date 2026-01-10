clc; clear all;

% Definizione Variabili Simboliche
syms x y theta beta real  % Stati
syms v alpha real         % Ingressi (Velocity, Steering)
syms Ts L L1 L2 real      % Parametri

% Vettori Stato e Ingresso
X = [x; y; theta; beta];
U = [v; alpha];

% --- EQUAZIONI DEL MODELLO (Dalla Traccia/Snippet) ---
% Nota: Trascrivo le equazioni visibili nello snippet della soluzione.
% Verifica i segni esatti sull'immagine del PDF originale se necessario.

% Termine comune complesso
term = (1 + (L1/L)*tan(beta)*tan(alpha)); 

% Equazioni differenziali (continue)
dx = v * cos(theta) * term; 
dy = v * sin(theta) * term;
dtheta = (v/L) * tan(alpha); % Dinamica sterzo motrice
dbeta = (v/L2) * sin(theta - beta); % Dinamica angolo rimorchio (semplificata standard)
% NOTA: Se la traccia ha una formula più complessa per dbeta, sostituiscila qui!

% Discretizzazione Eulero in avanti: x(k+1) = x(k) + f(x,u)*Ts
f_discrete = X + [dx; dy; dtheta; dbeta] * Ts;

% --- CALCOLO JACOBIANI ---
A_jac = jacobian(f_discrete, X);
B_jac = jacobian(f_discrete, U);

% Output formattato per copia-incolla
disp('%%% COPIA QUESTO IN jacStateFCN.m %%%');
disp('A = ...');
disp(simplify(A_jac));
disp(' ');
disp('B = ...');
disp(simplify(B_jac));