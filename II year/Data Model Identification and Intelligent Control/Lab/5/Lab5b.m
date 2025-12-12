%% LAB 5b: Identificazione di Sistemi Non Lineari (Hammerstein-Wiener)
%  ==============================================================
%  OBIETTIVO:
%  1. Generare segnali APRBS (Amplitude Modulated PRBS) per eccitare
%     le non-linearità di ampiezza.
%  2. Simulare un sistema non lineare (NLinSys).
%  3. Confrontare l'identificazione lineare (ARX) con quella non lineare (NLHW).
%  [Rif. Teoria: Cap. 6 - Identificazione sistemi non lineari, APRBS]
%  ==============================================================

clear all
close all
clc

%% 1. Generazione Segnale APRBS
% A differenza del PRBS (solo 2 livelli), l'APRBS cambia ampiezza casualmente.
% Questo è necessario per mappare la curva statica non lineare (es. saturazione).

N = 1000;
% Generiamo un segnale che varia ampiezza tra -4 e 4
% e mantiene il valore per intervalli casuali tra 5 e 35 campioni.
U = aprbs(N, 5, 35, -4, 4); 

figure(1)
plot(U)
title('Segnale di Ingresso APRBS');
ylim([-5 5]);

%% 2. Simulazione Sistema Non Lineare
% Il sistema è definito nella funzione 'NLinSys.m'.
% È un sistema NARX: y(t) = f(y(t-1), u(t-1))
% Nello specifico contiene una arcotangente (saturazione soft).

Y = zeros(1, N);
Y(1) = 0;
% Simulazione passo-passo
for t = 1:N-1
    Y(t+1) = NLinSys(Y(t), U(t));
end

Data = iddata(Y', U', 1);

figure(2)
plot(Data)
title('Dati I/O Sistema Non Lineare');

%% 3. Tentativo di Identificazione Lineare (ARX)
% Proviamo a fittare un modello lineare su un sistema non lineare.
% Usiamo la prima metà dei dati per training.

Zc = 500;
Train = Data(1:Zc);
Valid = Data(Zc+1:end);

m_arx = arx(Train, [2 2 1]);

% Vediamo come si comporta in validazione
figure(3)
compare(Valid, m_arx);
title('Validazione Modello Lineare ARX');
% NOTA: L'ARX cercherà di mediare, ma non potrà catturare la saturazione.

%% 4. Identificazione Non Lineare (Hammerstein-Wiener)
% Usiamo il comando 'nlhw' (Non-Linear Hammerstein-Wiener).
% Struttura: [Ingresso] -> [NL] -> [Linear] -> [NL] -> [Uscita]
% Specifichiamo che la non linearità in ingresso è "Piecewise Linear" (a tratti)
% e quella in uscita è lineare (nessuna).

% Sintassi: nlhw(Dati, [nb nf nk], InputNL, OutputNL)
% 'unit' = nessuna non linearità (lineare)
% 'pwlinear' = piecewise linear (approssima curve generiche)
% 'saturation' = saturazione classica

% Correzione Warning: Usiamo 'unit' invece di [] per l'uscita lineare
m_nl = nlhw(Train, [2 2 1], ...
            idPiecewiseLinear('Number', 10), ... % NL in ingresso (10 punti)
            'unit');                             % NL in uscita (assente)

% Confronto Lineare vs Non Lineare
figure(4)
compare(Valid, m_arx, m_nl);
legend('Dati Reali', 'ARX (Lineare)', 'NLHW (Non Lineare)');
title('Confronto Validazione: Lineare vs Non-Lineare');

%% 5. Analisi della Non-Linearità Stimata

% Estraiamo l'oggetto Non-Linearità dal modello stimato
NL_object = m_nl.InputNonlinearity;

% Estraiamo i punti (BreakPoints) che definiscono la spezzata
% bp è una matrice 2xN: la riga 1 sono le X (Ingresso), la riga 2 le Y (Uscita NL)
bp = NL_object.BreakPoints; 

figure(5)
% Plottiamo i punti estratti (bp)
plot(bp(1,:), bp(2,:), 'b-o', 'LineWidth', 1.5); 
hold on

% Sovrapponiamo la vera funzione (scalata come nel codice NLinSys)
% La funzione vera era: 0.1 * atan(u)
x_val = -4:0.1:4;
plot(x_val, 0.1 * atan(x_val), 'r--', 'LineWidth', 2);

legend('Stima NLHW (Piecewise)', 'Vera atan(u)');
title('Non-Linearità Statica: Stima vs Reale');
xlabel('Ampiezza Ingresso u(t)');
ylabel('Uscita blocco non-lineare w(t)');
grid on;


% Estraiamo e plottiamo la funzione statica stimata dal modello.
% Vogliamo vedere se ha "scoperto" l'arcotangente presente nel sistema vero.

% figure(5)
% plot(m_nl.InputNonlinearity); 
% title('Non-Linearità Statica Stimata (Ingresso)');
% xlabel('Ampiezza Ingresso u(t)');
% ylabel('Uscita blocco non-lineare w(t)');
% grid on;

%% ESERCIZIO:
% La curva plotata assomiglia a una arcotangente (atan)?
% (Il sistema vero era 0.1*atan(u) + 0.9*y)