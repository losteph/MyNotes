clc;
clear all;
close all;

Ts = 1;
Tf = 240;
Hp = 20;
Hc = 2;

mpcobj = nlmpc(3,3,'MV',[1 2],'MD',3);
mpcobj.PredictionHorizon = Hp;
mpcobj.Ts = Ts;
mpcobj.ControlHorizon = Hc;

mpcobj.Model.StateFcn = 'stateFunc';
mpcobj.Model.OutputFcn = 'outFunc';
% mpcobj.Jacobian.StateFcn = 'stateFuncJac';
% mpcobj.Jacobian.OutputFcn = 'outFuncJac';

% Initial states
x0 = [1.244 0 0];
u0 = [0 0];

mv = u0;
xk = x0;
md = 0;
ref = [0 0 0]; 

% Weights
mpcobj.Weights.OutputVariables(1) = 0;
mpcobj.Weights.OutputVariables(2) = 1;
mpcobj.Weights.OutputVariables(3) = 0;
% mpcobj.Weights.ManipulatedVariables(1) = 1;

% Constraints
mpcobj.MV(1).Min = 0;
mpcobj.MV(2).Min = 0;
mpcobj.MV(1).Max = 100;
mpcobj.MV(2).Max = 100;

mpcobj.OV(3).Max = 150;
mpcobj.OV(2).Min = 0;

validateFcns(mpcobj,xk,mv,md);

% History vectors init
x_history = [];
mv_history = [];
y_history = [];
c_history = [];
ref_history = [];
tvec = 0:Ts:Tf;

tic;
for i=0:length(tvec)-1 % Simulation loop
    if tvec(i+1) == 80 % impulsive disturbance
        md = 0.5;
    else
        md = 0;
    end
    
    % Reference
    if tvec(i+1) >= 5 && tvec(i+1) < 30
        refH = 1000;
    elseif tvec(i+1) >= 30 && tvec(i+1) < 50
        refH = 2000;
    elseif tvec(i+1) >= 50 && tvec(i+1) < 90
        refH = 3500;
    elseif tvec(i+1) >= 90 && tvec(i+1) < 130
        refH = 2000;
    elseif tvec(i+1) >= 130 && tvec(i+1) < 160
        refH = 3500;
    elseif tvec(i+1) >= 160 && tvec(i+1) < 210
        refH = 1000;   
    else
        refH = 0;
    end
    ref = [0 refH 0]; 
    
    [mv,~,info] = nlmpcmove(mpcobj,xk,mv,ref,md);

    xk = info.Xopt(2,:);
    y = info.Yopt(1,:);
    
    % History vectors
    ref_history = [ref_history; ref];
    x_history = [x_history; xk];
    y_history = [y_history; y];
    mv_history = [mv_history; mv'];
    c_history = [c_history; toc];
    tic;
end

fprintf("Tempo di esecuzione %.2f secondi.\n", sum(c_history))

plotter;