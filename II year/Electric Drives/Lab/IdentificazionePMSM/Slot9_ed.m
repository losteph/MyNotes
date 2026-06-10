clear; clc; close all;

J = 2.75*10^(-3);
B = 0.0042;
Td = 0.123;

np = 7;                      % Numero di coppie polari
PSIPM = 0.0523;              % Flusso dei magneti permanenti [Wb]
Kc = 3 * np * PSIPM / 2;     % Costante di coppia nominale [Nm/A]

wr = 300*2*pi/60;

isq= 3;
Ce = 3*np*PSIPM/2*isq;
Cr = 0;
v = (((Ce - Cr - Td) - B*wr)/J)*60/(2*pi); %velocità? o accelerazione?

%% Prima richiesta file 7
load('rec1_458.mat');
wr = rec1_458.Y(16).Data;
iq = rec1_458.Y(14).Data;

iq_50 = mean(iq(wr == -50));
iq_100 = mean(iq(wr== -100));
iq_150 = mean(iq(wr == -150));
iq_300 = mean(iq(wr == -300));
iq_400 = mean(iq(wr == -400));
iq_600 = mean(iq(wr == -600));

wr_rpm = [-50; -100; -150; -300; -400; -600];
wr_rads = wr_rpm * (2*pi/60);
y = [Kc*iq_50; Kc*iq_100; Kc*iq_150; Kc*iq_300; Kc*iq_400; Kc*iq_600];
phi = [wr_rads, ones(length(wr_rads), 1)];

%non divido wr con np perche è gia meccanica la velocita (credo)

theta=inv(phi' * phi) * phi' * y;

B_hat = theta(1);
Cd_hat = theta(2);

figure(1);
hold on; grid on;
plot(wr_rads, y, 'bo', 'MarkerSize', 8, 'LineWidth', 2, 'DisplayName', 'Dati Sperimentali');
x_line = linspace(min(wr_rads), max(wr_rads), 100);
y_line = B_hat * x_line + Cd_hat;
plot(x_line, y_line, 'r--', 'LineWidth', 2, 'DisplayName', 'Retta Interpolante');
xlabel('Velocità Meccanica [rad/s]');
ylabel('Coppia [Nm]');
legend('Location', 'best');

%% Seconda richiesta file 7
load('rec1_459.mat');

t_inerzia  = rec1_459.X.Data;
iq_inerzia = rec1_459.Y(12).Data;
wr_inerzia = rec1_459.Y(2).Data;

% Scegliamo un istante preciso in cui la corrente iq si è GIÀ azzerata.
t_scelto = 16.100; 
% in teoria corrisponde a t_inerzia(64445);

% Definiamo un intorno simmetrico strettissimo (t1 e t2) per calcolare la pendenza
t1_target = t_scelto - 0.01; % 10 millisecondi prima
t2_target = t_scelto + 0.01; % 10 millisecondi dopo

% Troviamo gli indici corrispondenti nei vettori dei dati di laboratorio
[~, idx1] = min(abs(t_inerzia - t1_target));
[~, idx2] = min(abs(t_inerzia - t2_target));

% Estrattechiamo i valori di velocità in quell'intorno (penso sia già
% quella meccanica?)
w1_mecc = wr_inerzia(idx1)*2*pi/60;
w2_mecc = wr_inerzia(idx2)*2*pi/60;
% li porto in rad/s per avere unità di misura conformi con quando abbiamo
% stimato B e Cd

% Calcolo della velocità media nell'intorno
w_media_mecc = (w1_mecc + w2_mecc) / 2;

% Calcolo della derivata (pendenza della retta tra t1 e t2)
dw_dt_mecc = (w2_mecc - w1_mecc) / (t_inerzia(idx2) - t_inerzia(idx1));

% Applicazione della formula della dispensa 7 per ricavare J
J_hat = - (B_hat * w_media_mecc + Cd_hat * sign(w_media_mecc)) / dw_dt_mecc;


figure(2)
plot(t_inerzia, wr_inerzia/np, 'b-'); hold on;
plot(t_scelto, w_media_mecc, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
xlabel('Tempo [s]');
ylabel('Velocità Meccanica [rad/s]');
title('Transitorio di decelerazione per stima J');
legend('Curva di decelerazione', 'Punto di calcolo');
grid on;