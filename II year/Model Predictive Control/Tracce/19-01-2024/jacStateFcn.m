function [A, B] = jacStateFcn(x,~)
    % Plant constants
    k = 0.8;            % Nm/rad
    b = 2.0 * 10^-1;    % Nm/rad/s
    m = 1.2;            % kg
    l = 0.4;            % m
    Jm = 0.5*10^-3;     % kg m^2
    g = 9.81;           % m/s^2
    
    % Derivative matrix of states with respect to states
    A = zeros(4,4);
    A(1,3) = 1;
    A(2,4) = 1;
    A(3,1) = (sin(x(1))*m*g*l - k)/(m*l^2);
    A(3,2) = k/(m*l^2);
    A(3,3) = -b/(m*l^2);
    A(3,4) = b/(m*l^2);

    A(4,1) = k/Jm;
    A(4,2) = -k/Jm;
    A(4,3) = b/Jm;
    A(4,4) = -b/Jm;
    
    % Derivative matrix of states with respect to inputs
    B = zeros(4,1);
    B(4,1) = 1/Jm;
end

