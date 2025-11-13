function dxdt = stateFcn(x,u)
    % Plant constants
    k = 0.8;            % Nm/rad
    b = 2.0 * 10^-1;    % Nm/rad/s
    m = 1.2;            % kg
    l = 0.4;            % m
    Jm = 0.5*10^-3;     % kg m^2
    g = 9.81;           % m/s^2

    u1 = u(1);      % MV
    tau_m = u(2);   % MD

    dxdt = zeros(4,1);
    dxdt(1) = x(3);
    dxdt(2) = x(4);
    dxdt(3) = (-m*g*l*cos(x(1)) -k*(x(1) - x(2)) - b*(x(3)-x(4)) + tau_m)/(m*l^2);
    dxdt(4) = (u1 + b*(x(3)-x(4)) -k*(x(2) - x(1)))/Jm;
end

