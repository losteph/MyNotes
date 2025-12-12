%% LAB 2: Analisi Asintotica (Caso ARMAX)
%  ==============================================================
%  OBIETTIVO:
%  Estendere l'analisi di consistenza al caso ARMAX.
%  Qui il disturbo non è bianco, ma filtrato da un polinomio C(z).
%  Verifichiamo la convergenza dei parametri A, B e C separatamente.
%  ==============================================================

clear 
close all
clc

%% 1. Generazione del Sistema ARMAX (MGD)

Ts = 0.01;
Tend = 10000 * Ts;
t = (0:Ts:Tend)';
Nmax = length(t);

% Creazione sistema a tempo continuo e discretizzazione
G = zpk(10, [-20 -20 -50 -100], -400*50*10);
Gz = c2d(G, Ts); 

% Definizione manuale dei polinomi (arrotondati)
% Struttura ARMAX: A(z)y(t) = B(z)u(t-nk) + C(z)e(t)
% [Rif. Teoria: Paragrafo 2.1.4 ARMAX]
A = [1.00 -2.61  2.49 -1.02 0.15];
B = [0    -0.02 -0.03  0.05 0.01];
C = [1     1.9   0.4]; % Polinomio della media mobile sul rumore

% Visualizzazione sistema
figure(1)
impulse(Gz)
title('Risposta Impulsiva Sistema ARMAX Vero')

%% 2. Generazione Dati Simulati

% Creazione oggetto idpoly ARMAX
% Sintassi: idpoly(A, B, C, D, F, NoiseVar, Ts)
NoiseVariance = 1e-6; % Varianza piccola
S = idpoly(A, B, C, [], [], NoiseVariance, Ts);

% Generazione segnali (Esplicita)
U = randn(Nmax, 1);
E = randn(Nmax, 1);

% Simulazione: Qui il rumore E viene filtrato da 1/A(z) * C(z)
Y = sim(S, [U E]);

Dati = iddata(Y, U, Ts);
Dati.InputName = 'Ingresso';
Dati.OutputName = 'Uscita';

%% 3. Identificazione con N crescente (Stile Lineare)

% Creazione dataset parziali
Dati50   = Dati(1:50);
Dati500  = Dati(1:500);
Dati1000 = Dati(1:1000);
Dati9500 = Dati(1:9500);

% Stima modelli ARMAX
% Ordini scelti coerenti con il vero: na=4, nb=4, nc=2, nk=1
% Nota: ARMAX usa algoritmi iterativi (non formula chiusa come ARX),
% quindi potrebbe richiedere più tempo o dare risultati diversi run dopo run.
m50   = armax(Dati50,   [4 4 2 1]);
m500  = armax(Dati500,  [4 4 2 1]);
m1000 = armax(Dati1000, [4 4 2 1]);
m9500 = armax(Dati9500, [4 4 2 1]);

%% 4. Calcolo Errori Parametrici per A, B e C

% Estrazione parametri
[B_50, A_50, C_50]       = tfdata(m50, 'v');
[B_500, A_500, C_500]    = tfdata(m500, 'v');
[B_1000, A_1000, C_1000] = tfdata(m1000, 'v');
[B_9500, A_9500, C_9500] = tfdata(m9500, 'v');

% Calcolo errore Norma Euclidea separato per polinomi
% Questo ci permette di vedere se C converge peggio di A e B
ErrA = [norm(A_50-A) norm(A_500-A) norm(A_1000-A) norm(A_9500-A)];
ErrB = [norm(B_50-B) norm(B_500-B) norm(B_1000-B) norm(B_9500-B)];
ErrC = [norm(C_50-C) norm(C_500-C) norm(C_1000-C) norm(C_9500-C)];

% Vettore asse X
N_vec = [50 500 1000 9500];

%% 5. Plot Comparativo

figure(2)
semilogx(N_vec, ErrA, '-o', 'LineWidth', 2, 'DisplayName', 'Errore su A'); hold on;
semilogx(N_vec, ErrB, '-s', 'LineWidth', 2, 'DisplayName', 'Errore su B');
semilogx(N_vec, ErrC, '-^', 'LineWidth', 2, 'DisplayName', 'Errore su C');
grid on
xlabel('Numero di Campioni (N)');
ylabel('Errore Parametrico ||Theta_0 - Theta_hat||', 'Interpreter', 'none');
title('Convergenza Parametrica ARMAX');
legend('Location', 'Best');

% Analisi Residui sul modello finale
figure(3)
resid(Dati(9501:end), m9500); 
title('Analisi Residui (Modello m9500)');