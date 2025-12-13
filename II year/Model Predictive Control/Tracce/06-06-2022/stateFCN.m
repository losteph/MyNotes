function dx = stateFCN(x,u,params)
    % x1 = xp
    % x2 = yp
    % x3 = theta_p
    % u1 = Vc
    % u2 = omega
    Ts = params(1);
    dx = zeros(3,1);

    dx(1) = x(1) + u(1) * cos(x(3)) * Ts;
    dx(2) = x(2) + u(1) * sin(x(3)) * Ts;
    dx(3) = x(3) + u(2) * Ts;
end