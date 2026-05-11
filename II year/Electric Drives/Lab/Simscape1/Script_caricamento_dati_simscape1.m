%%%% Script caricamento dati e simulazione azionamento elettrico con dati azionamento Nottingham - versione per gli studenti del corso di Electric Drives %%%%

%v1 - 06/10/2022: Prima versione - Verificato (Elia Brescia)
%v2 - 12/10/2022: Modifica formula coppia di carico - Verificato (Elia Brescia)

%% Caricamento percorsi e dati macchina
addpath(cd,'File azionam');
addpath(cd,'Dati vari');

load('f_AC.mat')
load('Rs_AC.mat')
load('Rs_map.mat')
% load('T_mean.mat')
load('Psi_map_torque.mat')

%% Controllo utente script
Simulazione=0;    % 0: non esegue la simulazione   |   1: esegue automaticamente la simulazione 
Grafici=0;        % 0: non traccia i grafici       |   1: traccia i grafici

%% PARAMETRI PMSM
ms = 3;              %Numero fasi
np=2;                %Numero coppie polari
Rs = 0.6975;         %Resistenza DC a temperatura ambiente 
Lsd = 1.251e-3;      %Induttanza a corrente nulla
Lsq = Lsd; 
Psim = 26.82e-3;              %Valore a vuoto a temperatura ambiente 
Psim_nom=25.98e-3;            %Valore alla temperatura nominale 
Kc=3/2*np*Psim;
Kc_nom=3/2*np*Psim_nom;

B =4.2373e-06;       %Coefficiente di attrito viscoso (Desunto da misure di coppia a vuoto)
J = 0.04e-3*3;      %Momento di inerzia (Non misurato ma valore plausibile)

%% Dati variazioni parametriche

%Dipendenza temperatura
Trif=298.15;          %Temperatura di riferimento per i parametri di macchina (equivale a 25 °C) [K] 
alpha=3.93e-3;        %Coefficiente di temperatura resistenza rame [1/K]
alpha_PM=-0.035/100;  %Coefficiente di temperatura induzione residua PM (Recoma 28) [1/K]

%Dipendenza intensità di corrente
Lsd_Matrix=[1 1 1; 1 1 1; 1 1 1];               %In riga la dipendenza dalla id in colonna la dipendenza dalla iq  
Lsq_Matrix=[1 1 1; 1 1 1; 1 1 1];               %In riga la dipendenza dalla id in colonna la dipendenza dalla iq                                                         
lambdam_Matrix=[1 1 1; 1 1 1; 1 1 1];           %In riga la dipendenza dalla id in colonna la dipendenza dalla iq

Table_Matrix_Lsd=array2table(Lsd_Matrix,'VariableNames',{'-Iqn', '0Iqn', 'Iqn'},'RowNames',{'-Idn', '0Idn', 'Idn'});
Table_Matrix_Lsq=array2table(Lsq_Matrix,'VariableNames',{'-Iqn', '0Iqn', 'Iqn'},'RowNames',{'-Idn', '0Idn', 'Idn'});

%Dipendenza frequenza
f_AC_corr=[f_AC(1); f_AC(5:end)];
Rs_AC_corr=[Rs_AC(1); Rs_AC(5:end)];
Ratio_Rs_AC=(Rs_AC_corr-Rs)/Rs;
pol=polyfit(f_AC_corr,Ratio_Rs_AC,2);

%Temperature regime (specificare in °C)
Trotor=77.4950000000000;          
Tphase=77.4950000000000;

Trotor=100;          
Tphase=100; 

%Valore atteso flusso
PsimT=Psim*(1+alpha_PM*(Trotor+273.15-Trif));    %Valore flusso effettivo [Wb]

Kc_act=3/2*np*PsimT;                             %Costante di coppia effettiva [Nm/A]

%% PARAMETRI INVERTER E FILTRI
Vdc = 540;                  %Tensione del bus in continua [V]
kpPLL = 15; kiPLL = 2.5e6;  %costanti taratura Resolver
np_res=2;                   %numero di poli del resolver
Vf=1e-6;                    %Tensione di conduzione MOSFET V (senza considerare la resistenza di conduzione)   [V]
Ron=0.015;                  %Resistenza di conduzione MOSFET [Ohm]
goff=10e-6/1200;            %Conduttanza in stato OFF MOSFET [S]
Vf_diode=2;                 %Tensione di conduzione diodo di ricircolo  [V]
Rond=1e-6;                  %Resistenza di conduzione diodo di ricircolo [Ohm]
goffd=10e-6/1200;           %Conduttanza in stato OFF diodo di ricircolo [S]

%% Dati nominali macchina
In=14;                      %corrente nominale [A]
Crn=In*Kc_nom;              %coppia di carico nominale [Nm]
wrn=30000;                  %velocità nominale [RPM]
Pn=Crn*wrn*2*pi/60;         %potenza nominale calcolata [Nm]

Tmax = 1.5*Crn;                 %coppia massima [Nm]
Imax = Tmax/Kc_nom;             %corrente massima [A] 
Pmax = 3*Vdc/2*Imax;            %potenza massima [W]

%% Riferimento di velocità e coppia di carico
wrr=wrn/5*1;                        %Riferimento di velocità meccanica [RPM]
% Cr=Crn;                           %Coppia di carico [Nm]
Cr=In*2/4*Kc_act; 
%Coppia di carico [Nm]
Cr0=0;
tload=0.25;                         %Istante applicazione carico [s]
tend=0.65;                          %Durata simulazione [s]

%% VALORI INIZIALI DELLE VARIABILI STATO
wr0 = 0; %wrr*2*pi/60; 
teta0 = 0; %velocità e posizione iniziali meccaniche
wdq0 = wr0*np; tetadq0 = teta0*np;  %velocità e posizione elettriche
isd0 = 0; %corrente iniziale lungo l'asse d
isq0 = (B*wdq0/J + np*Cr0/J)/(Kc*np/J + ms*np^(2)*(Lsd-Lsq)*isd0/(2*J)); %corrente iniziale lungo l'asse q

%% TEMPI SIMULAZIONE
TT_sc = 5e-5;      %Periodo sistema di controllo
TT_swt = 5e-5;     %Periodo PWM (portante)
% TT_c = TT_swt/1000;   %Periodo fondamentale. Almeno tt_swt/50
TT_c = TT_swt/100;       %Periodo fondamentale. Almeno tt_swt/50

%% TARATURA CONTROLLORI 
tsigmai = TT_swt/2+TT_sc; %convertitore+microcontrollore

%%%regolatore isq
tiisq = Lsq/Rs;
% kpisq = Rs*tiisq/(2*tsigmai); %Formule del modulo ottimo, verificate. 
kpisq=23.6;                     %Determinato con ottimizzazione
kiisq = kpisq/tiisq;
kaisq = 1000;                   %costante del filtro antiwindup

%%%regolatore isd
tiisd = Lsd/Rs;
% kpisd = Rs*tiisd/(2*tsigmai); %Formule del modulo ottimo, verificate. 
kpisd=23.6;                     %Determinato con ottimizzazione
kiisd = kpisd/tiisd;
kaisd = 1000; %costante del filtro antiwindup

%%%regolatore wr
% tsigmaw = 2*tsigmai;
% tiw = 4*tsigmaw; % Formule dell'ottimo simmetrico
% kpwr = J/(np*Kc*2*tsigmaw); %ottimo simmetrico 
% kiwr = kpwr/(tiw);
% kawr = 1000; %costante del filtro antiwindup

%Parametri ottimizzati 
kpwr = 0.12;
kiwr = 600;
kawr = 1000; %costante del filtro antiwindup

%% Simulazione azionamento

if Simulazione==1

    tic
    sim('Simscape1_risolta.mdl')
    toc

Total_energy_loss=3/2*sum(Rs_tot.*(id.^2+iq.^2))*TT_sc;
    
    if Grafici==1
        %% Settaggio grafici - nuovo (metodo Diego Calabrese)
        
        % Dimensioni figure in cm
        
        %%Per una colonna intera su Template IEEE
        % width = 8.8; %cm   
        % height = 5.3; %cm
        
        %%Per inserire due immagini affiancate in un colonna su Template IEEE
        % width=4.2;      
        % height=3.8;     
        
        %Custom induttanza
        % width=5;            
        % height=3; 
        
        %Custom resistenza e flusso
        width=16;            
        height=12; 
        
        % figure margins in cm
        top= 0.1;  
        bottom= 0.9;	
        left= 1.2;	
        right= 0.3;
        
        %%%Per mettere due immagini affiancate in una colonna
        
        %set default figure configurations
        set(0,'defaultFigureUnits','centimeters');
        set(0,'defaultFigurePosition',[5 5 width height]);
        set(0,'defaultLineLineWidth',1.5);
        set(0,'defaultAxesLineWidth',0.5);
        set(0,'defaultAxesYGrid','on');
        set(0,'defaultAxesXGrid','on');
        set(0,'defaultAxesFontName','Times New Roman');
        set(0,'defaultTextFontName','Times New Roman');
        set(0,'defaultAxesFontWeight','Bold');
        set(0,'defaultTextFontWeight','Bold');
        set(0,'defaultLegendFontName','Times New Roman');
        set(0,'defaultAxesFontSize',8,'defaultAxesFontSizeMode','manual');
        set(0,'defaultLegendFontSize',12,'defaultLegendFontSizeMode','manual');
        set(0,'defaultAxesPosition',[left/width bottom/height (width-left-right)/width (height-top-bottom)/height],'units','centimeters');
        set(0,'defaultAxesTickDir','out');
        set(0,'defaultLegendLocation','best');
        
        %IMPORTANTE: PER AVERE LE YLABEL ALLINEATE BISOGNA INSERIRE IN YLABEL, DOPO
        %LA STRINGA TESTO 'Units','centimeters','Position',[-0.8043 2.1484 0]
        
        %Queste impostazioni di default restano per sempre.
        %Per togliere in command window: reset(0)
        
        %Il salvataggio va fatto da file/export setup
        %Render ->600 dpi
        %Export ->.tif
        
        %% Grafici
        %Velocità e posizione PMSM
        figure(1)
        
        subplot(2,1,1);
        plot(tsSim_sampled,wrefRotor_RPM,'LineWidth',1.5)
        hold on,
        plot(tsSim_sampled,wRotorMecc_RPM,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Velocità [RPM]','FontSize',12)
        title('Velocità','FontSize',12)
        leg=legend('Riferimento di velocità','Velocità meccanica misurata non filtrata','FontSize',12);
        grid on
        
        subplot(2,1,2);
        plot(tsSim_sampled,Kc*IqMis_err_NF,'LineWidth',1.5)
        hold on,
        plot(tsSim_sampled,-C_load,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Coppia [Nm]','FontSize',12)
        title('Coppia','FontSize',12)
        leg=legend('Coppia elettromagnetica','Coppia di carico','FontSize',12);
        grid on
        
        %Tensioni e correnti dq
        figure(2)
        subplot(2,2,1);
        plot(tsSim,VdMis_no_err_NF,tsSim,VdMis_no_err_F,tsSim_sampled,vdRef,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Tensione [V]','FontSize',12)
        legend('Misurata non filtrata','Misurata Filtrata','Riferimento')
        title('Vd','FontSize',12)
        % xlim([0.1 0.102])
        grid on
        
        subplot(2,2,3);
        plot(tsSim_sampled,IdMis_no_err,tsSim_sampled,IdMis_err_NF,tsSim_sampled,IdMis_err_F,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Corrente [A]','FontSize',12)
        title('id','FontSize',12)
        legend('Senza errori','Con errori non filtrata','Con errori filtrata')
        grid on
        
        subplot(2,2,2);
        plot(tsSim,VqMis_no_err_NF,tsSim,VqMis_no_err_F,tsSim_sampled,vqRef,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Tensione [V]','FontSize',12)
        legend('Misurata non filtrata','Misurata Filtrata','Riferimento')
        title('Vq','FontSize',12)
        grid on
        
        subplot(2,2,4);
        plot(tsSim_sampled,IqMis_no_err,tsSim_sampled,IqMis_err_NF,tsSim_sampled,IqMis_err_F,'LineWidth',1.5)
        xlabel('Tempo [s]','FontSize',12),ylabel('Corrente [A]','FontSize',12)
        title('iq','FontSize',12)
        legend('Senza errori','Con errori non filtrata','Con errori filtrata')
        grid on
        
        %Tensione sul dc-link
        figure(3)
        plot(tsSim_sampled,Dc_voltage_no_err,tsSim_sampled,Dc_voltage_err_NF,tsSim_sampled,Dc_voltage_err)
        legend('Vdc senza errori', 'Vdc con errori non filtrata', 'Vdc con errori filtrata')
        title('Dc voltage')
    end
end

%Nominarle tipo:
%  'Bonf65_500ST_0.5wrn_0.25Crn.mat'