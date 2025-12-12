%% LAB 5a: Effetti del Pre-filtraggio nell'Identificazione
%  ==============================================================
%  OBIETTIVO:
%  1. Osservare come un modello ARX, applicato a dati generati da un sistema
%     Box-Jenkins (o Output Error), sbagli la stima in bassa frequenza (errore a regime).
%  2. Correggere l'errore applicando un Pre-filtro L(z).
%  3. Confrontare diverse strategie di filtraggio.
%  [Rif. Teoria: Paragrafo 5.4.1 - Pre-filtraggio]
%  ==============================================================

clear 
clc
close all

%% 1. Generazione del Sistema (MGD)
% Creiamo un sistema con rumore bianco in uscita (Output Error).
% MGD: y(t) = G(z)u(t) + e(t)  <-- Il rumore NON passa per i poli del sistema

Ts = 1;
A0 = [1 -1.5 0.7];
B0 = [0  1   0.5];
G0 = tf(B0, A0, Ts); % Funzione di trasferimento vera

% Generazione dati
N = 1000;
U = randn(N, 1);
Y_clean = filter(B0, A0, U); % Uscita pulita

% Aggiunta Rumore (Bianco)
% Normalizziamo affinché la potenza del rumore sia il 10% del segnale
V = randn(N, 1);
V = V/std(V) * std(Y_clean) * sqrt(0.1); 
Y = Y_clean + V;

Data = iddata(Y, U, Ts);

%% 2. Identificazione Standard (Senza Filtro)
% Usiamo un ARX. L'ARX assume che il rumore sia filtrato da 1/A(z).
% Poiché nel nostro MGD il rumore è bianco (non filtrato), l'ARX sbaglierà
% a stimare A(z) per cercare di adattarsi al rumore.

m_arx = arx(Data, [2 2 1]);

figure(1)
compare(Data, m_arx);
title('Confronto Temporale (Senza Prefiltro)');

% Analisi in Frequenza (Bode) e a Gradino (Step)
% Qui vedremo che l'ARX sbaglia il guadagno statico (bassa frequenza)
figure(2)
step(G0, m_arx);
legend('Sistema Vero', 'ARX Standard');
title('Risposta al Gradino: Errore a Regime');

%% 3. Applicazione del Pre-filtro (Iterativo)
% Teoria: Se filtriamo u e y con un filtro L(z), è come se filtrassimo
% l'errore di predizione. Usare un filtro passa-basso migliora la stima statica.
% Strategia comune: Usare come filtro l'inverso del polinomio A stimato (1/A).

% --- Iterazione 1 ---
A_hat = m_arx.A; % Polinomio A stimato al passo precedente

% Filtriamo i dati
U_f = filter(1, A_hat, U);
Y_f = filter(1, A_hat, Y);
Data_f = iddata(Y_f, U_f, Ts);

% Nuova identificazione sui dati filtrati
m_f1 = arx(Data_f, [2 2 1]);

% --- Iterazione 2 (Raffinamento) ---
% Usiamo il nuovo A stimato per filtrare meglio
A_hat2 = m_f1.A;
U_ff = filter(1, A_hat2, U);
Y_ff = filter(1, A_hat2, Y);
Data_ff = iddata(Y_ff, U_ff, Ts);

m_f2 = arx(Data_ff, [2 2 1]);

%% 4. Confronto Finale
figure(3)
step(G0, m_arx, m_f1, m_f2);
legend('Sistema Vero', 'ARX No-Filter', 'ARX Filter (Iter 1)', 'ARX Filter (Iter 2)');
title('Miglioramento della Risposta al Gradino con Pre-filtraggio');

figure(4)
bode(G0, m_arx, m_f2);
legend('Sistema Vero', 'ARX No-Filter', 'ARX Filter (Iter 2)');
title('Confronto Diagrammi di Bode');

% NOTA: Il pre-filtraggio "sposta" l'attenzione dell'algoritmo.
% Migliora la bassa frequenza (guadagno statico) a discapito, a volte,
% dell'alta frequenza.

%% 5. PARTE B: Riepilogo (Summary Exercise) - Filtro Ottimo
% Se conoscessimo il vero modello del rumore H(z), il filtro ottimo
% sarebbe L(z) = 1/H(z). Proviamo un caso sintetico.

fprintf('\n--- Parte B: Confronto filtri (1/A vs Filtro Ottimo) ---\n');

% MGD: y = G*u + H*e  (Box-Jenkins)
% Definiamo un H(z) = C(z)/D(z) diverso da 1/A(z)
NoiseFilter = tf([1 0.8], [1 -0.9], Ts); % Rumore fortemente colorato
Noise = lsim(NoiseFilter, randn(N,1), (0:N-1)*Ts);
Y_bj = Y_clean + Noise;
Data_bj = iddata(Y_bj, U, Ts);

% 1. ARX Standard
m_bj_arx = arx(Data_bj, [2 2 1]);

% 2. ARX con Pre-filtro 1/A (Empirico)
A_tmp = m_bj_arx.A;
Data_filt_A = iddata(filter(1, A_tmp, Y_bj), filter(1, A_tmp, U), Ts);
m_bj_filtA = arx(Data_filt_A, [2 2 1]);

% 3. ARX con Pre-filtro "Perfetto" (Inverso del rumore vero - Caso Ideale)
% L = H^-1. Nella pratica non lo conosciamo, ma serve per confronto teorico.
[numH, denH] = tfdata(NoiseFilter, 'v');
Data_filt_Opt = iddata(filter(denH, numH, Y_bj), filter(denH, numH, U), Ts);
m_bj_opt = arx(Data_filt_Opt, [2 2 1]);

figure(5)
step(G0, m_bj_arx, m_bj_filtA, m_bj_opt);
legend('Vero', 'ARX Standard', 'Filtro 1/A', 'Filtro Ottimo (InvNoise)');
title('Confronto Strategie di Filtraggio');