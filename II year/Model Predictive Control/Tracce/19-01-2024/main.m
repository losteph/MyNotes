% MPC Exam 19/01/2024
% Example of a possible solution for the exam. 
% There are multiple approaches to solving exam questions. 
% This is one of them.

clc;
clear all;
close all;

nx = 4; % Number of states
ny = 1; % Number of MV

% Create NLMPC object
mpcobj = nlmpc(nx,ny,'MV',1,'MD',2);

% Setting the model
mpcobj.Model.StateFcn = 'stateFcn';     % Set the state function
mpcobj.Model.OutputFcn = 'outputFcn';   % Set the output function

% Setting Jacobians (question A)
mpcobj.Jacobian.StateFcn = 'jacStateFcn'; % Set the Jacobian for the state function
mpcobj.Jacobian.OutputFcn = 'jacOutFcn'; % Set the Jacobian for the state function

% Main MPC Controller parameters (question B)
Ts = 0.1;
Hp = 10;
Hc = 2;

mpcobj.Ts = Ts;                 % Set sampling time
mpcobj.PredictionHorizon = Hp;  % Set prediction horizon
mpcobj.ControlHorizon = Hc;     % Set control Horizon

% Question C
% It is not necessary to change any parameters. 
% If we wanted to make the control action more aggressive, 
% we could reduce the prediction horizon (to increase the 
% dependence on the measurable disturbance) or increase the 
% weight on the output by a few orders of magnitude.

% Question D
% mpcobj.States(3).Min = -deg2rad(80);
% mpcobj.States(3).Max = deg2rad(80);

% Gains of the PD Controller (approximation of the nervous system).
kp = 40;
kd = 15;

% Initial input
mv = 0;

% Initial states
xk = zeros(1,4);

t = 0:0.1:10;   % Time vector for the simulation
N = length(t);  % Number of steps of the simulation

% History vectors
y_history = [];
u_history = [];
md_history = [];
ref_history = [];
J_history = [];
t_history = [];

% Validate the controller (question B)
validateFcns(mpcobj,rand(4,1),rand(),rand());

%% Control loop
for i=1:N
    % Set the reference
    if (i*Ts>=3 && i*Ts<4)
        ref = pi/2;
    elseif (i*Ts>=7 && i*Ts<8)
        ref = deg2rad(100);
    else
        ref = 0;
    end
    
    % Update the measured disturbance
    tau_m = kp*(ref-xk(1)) - kd*xk(3);
    % Saturate tau_m in range +-2 Nm
    tau_m = min(2, max(-2, tau_m));

    % Compute the optimal solution
    tic();
    [mv,~,info] = nlmpcmove(mpcobj,xk,mv,ref,tau_m);
    time = toc();

    % Update the state
    xk = info.Xopt(2,:);
    % Update the output
    y = info.Yopt(1,:);

    % Update history vectors
    y_history = [y_history;y];
    u_history = [u_history;mv];
    md_history = [md_history;tau_m];
    ref_history = [ref_history; ref];
    J_history = [J_history; info.Cost];
    t_history = [t_history; time];
end

%% Plot

% Output plot
figure(1);
plot(t,rad2deg(y_history));
grid minor
hold on
stairs(t,rad2deg(ref_history));
xlabel("Time [s]")
ylabel("Knee angle [°]")

% Computational time plot (question E)
figure(2);
plot(t,t_history)
xlabel("Time [s]")
ylabel("Computational time [s]")
grid minor

% Cost plot (question F)
figure(3)
plot(t,J_history)
grid minor
xlabel("Time [s]")
ylabel("Cost")
