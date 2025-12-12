%% LAB 5b: Identificazione Non Lineare (Hammerstein-Wiener)
%  ==============================================================
%  OBIETTIVO:
%  Identificare un sistema che presenta saturazioni o non-linearità.
%  Confronto tra approccio Lineare (ARX) e Non Lineare (NLHW).
%  Uso di segnali APRBS per eccitare le diverse ampiezze.
%  ==============================================================
% (utilizzando aprbs e NlinSys del Prof.)

clear all
close all
clc

%% 1. Generazione Segnale APRBS
% Usiamo la funzione del prof 'aprbs.m'.
% Parametri: N=500, Durata gradino tra 5 e 35, Ampiezza tra -4 e 4.
% Un segnale lento (35) serve a vedere bene il regime stazionario.

N = 500;
u = aprbs(N, 5, 35, -4, 4); 

% Visualizziamo l'ingresso
figure(1)
plot(u)
title('Segnale di Ingresso APRBS (Multilivello)');
xlabel('Campioni'); ylabel('Ampiezza');

%% 2. Simulazione del Sistema Non Lineare
% Il sistema è definito nel file 'NLinSys.m'.
% Equazione: y(t) = 0.9*y(t-1) + 0.1*atan(u(t-1))

y = zeros(1, N); % Pre-allocazione
% Simulazione passo-passo
for t = 1 : N-1
    % Nota: passiamo y(t) e u(t) per calcolare y(t+1)
    y(t+1) = NLinSys(y(t), u(t));
end

% Creazione oggetto iddata
% Trasponiamo ' con u' e y' per avere vettori colonna
data = iddata(y', u', 1);

figure(2)
plot(data)
title('Dati I/O Generati dal Sistema Non Lineare');

%% 3. Identificazione: Lineare vs Non Lineare

% Dividiamo i dati in metà training e metà validation
Zc = 250;
Train = data(1:Zc);
Valid = data(Zc+1:end);

% --- TENTATIVO 1: Modello Lineare (ARX) ---
% Proviamo a spiegare i dati con un modello lineare semplice.
m_arx = arx(Train, [2 2 1]);

% --- TENTATIVO 2: Modello Non Lineare (Hammerstein-Wiener) ---
% Usiamo il comando 'nlhw'.
% InputNL: Piecewise Linear (approssima la forma dell'atan)
% OutputNL: Unit (nessuna non linearità in uscita)
% Ordini [nb nf nk] = [2 2 1] simili all'ARX per confronto equo.

% Sintassi aggiornata per MATLAB recente:
m_nl = nlhw(Train, [2 2 1], ...
            idPiecewiseLinear('Number', 10), ... % NL Ingresso
            []);                                 % NL Uscita (Lineare)

%% 4. Validazione e Confronto
% Confrontiamo come i due modelli si comportano su dati nuovi

figure(3)
compare(Valid, m_arx, m_nl);
legend('Dati Reali', 'ARX (Lineare)', 'NLHW (Non Lineare)');
title('Confronto Validazione');

% ANALISI DEI RISULTATI (Cosa osservare):
% 1. ARX: Cerca di seguire la media, ma "taglia" i picchi o sbaglia
%    l'ampiezza quando l'ingresso è alto (zona di saturazione).
% 2. NLHW: Dovrebbe sovrapporsi quasi perfettamente ai dati reali,
%    perché ha imparato la curva di saturazione.

%% 5. Ispezione della Non-Linearità
% Possiamo estrarre dal modello la curva statica che ha imparato
% e confrontarla con la vera non-linearità (0.1 * atan(u)).

figure(4)
% Plot della non-linearità stimata dal modello
plot(m_nl.InputNonlinearity); 
hold on
% Sovrapponiamo la vera funzione (scalata come nel codice NLinSys)
x_val = -4:0.1:4;
plot(x_val, 0.1 * atan(x_val), 'r--', 'LineWidth', 2);
legend('Stima NLHW', 'Vera atan(u)');
title('Non-Linearità Statica: Stima vs Reale');
grid on;

%% Esercizi
% 1. Prova con segnali più veloci (es. aprbs(500, 1, 5, -4, 4)).
%    Vedrai meglio il transitorio ma peggio la statica.
% 2. Cambia il range dell'ingresso a [-6, 6].
%    La saturazione sarà ancora più evidente.