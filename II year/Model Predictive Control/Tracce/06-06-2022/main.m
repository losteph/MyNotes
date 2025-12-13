%% INIZIO SEZIONE QUI
clc;
clear all;
close all;

% Parameters
Tf = 10;
Ts = 0.5;
Hp = 30;
Hc = 10;
t = 0:Ts:Tf;
epsilon = 0.1; % Value for the stop condition

% Defining non linear MPC controller
mpcobj = nlmpc(3,3,2);
% Defining Ts, Hp, Hc
mpcobj.Ts = Ts;
mpcobj.PredictionHorizon = Hp;
mpcobj.ControlHorizon = Hc;
% Declaring state and output functions
mpcobj.Model.StateFcn = 'stateFCN';
% Declaring state jacobians
mpcobj.Jacobian.StateFcn = 'jacStateFCN';
% Defining controller parameters
mpcobj.Model.NumberOfParameters = 1;

mpcobj.Model.IsContinuousTime = false;
% Weights
mpcobj.Weights.OutputVariables(1) = 20;
mpcobj.Weights.OutputVariables(2) = 20;
mpcobj.Weights.OutputVariables(3) = 57;
% Constraints
% Limit on delta_u = 100°/s^2 = limit *Ts
mpcobj.ManipulatedVariables(2).RateMin = -deg2rad(100*Ts);
mpcobj.ManipulatedVariables(2).RateMax = deg2rad(100*Ts);
% Defining options object
options = nlmpcmoveopt;
options.Parameters = {Ts};
validateFcns(mpcobj,rand(3,1),rand(2,1),[],options.Parameters)
%% FINE SEZIONE QUI
% History vectors
u_history = [];
y_history = [];
x_history = [];
t_history = [];

% Initial state
x0 = [0;0;0];
xk = x0;
mv = [0;0];
ref = [1;1;deg2rad(45)]';


% Control loop
for k=1:length(t)
    [mv,opt,info] = nlmpcmove(mpcobj,xk,mv,ref,[],options);

    xk = info.Xopt(2,:);
    y = info.Yopt(1,:);

    % Store history info
    u_history = [u_history; mv'];
    x_history = [x_history; xk];
    y_history = [y_history; y];
    t_history = [t_history; t(k)];

    % STOP CONDITION
    if sqrt((ref(1)-y(1))^2 + (ref(2)-y(2))^2) < epsilon
        break; % Stop if the output is close to the reference
    end
end

%% Plotting
figure(1);
subplot(2,1,1)
stairs(t_history, u_history(:,1), 'LineWidth',5);
grid on
subplot(2,1,2)
stairs(t_history, rad2deg(u_history(:,2)), 'LineWidth',5);
grid on

figure(2)
for i=1:3
    subplot(3,1,i);
    if i==3
        plot(t_history,rad2deg(y_history(:,i)), 'LineWidth',5);
        hold on 
        yline(rad2deg(ref(i)), 'red')
    else
        plot(t_history,y_history(:,i), 'LineWidth',5);
        hold on
        yline(ref(i), 'red')
    end   
    grid on
end

figure(3)
plot(y_history(:,1),y_history(:,2), 'LineWidth',3);
grid on
hold on
%scatter(ref(1),ref(2),10)
axis equal
xlim([0 2])
ylim([0 2])