function [A,Bmv] = stateFuncJac(x,u)
    alpha = 5.098;
    gamma = 5.257;
    mu    = 0.1961;
    omega = 8.544;
    delta = 0.0255;
    beta  = 0.01683;

    % utils
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
   
    % Get inputs
    u1 = u(1);
    u2 = u(2);
    
    A = zeros(3,3);
    Bmv = zeros(3,2);

    A(1,1) = - omega*abs(x1) - omega*x1*sign(x1);
    A(1,2) = alpha*mu*(gamma-1)*(-delta)*((1-delta*x2)^(gamma-2))*(1-(1-delta*x2)/x3) + alpha*mu*((1-delta*x2)^(gamma-1)) * (delta/x3);
    A(1,3) = alpha*mu*((1-delta*x2)^(gamma-1))*(1-delta*x2)/(x3^2);

    A(2,1) = 1;
    A(2,2) = 0;
    A(2,3) = 0;
    
    A(3,1) = -delta*(beta+u2);
    A(3,2) = 0;
    A(3,3) = -(beta + u2);


    Bmv(1,1) = 0;
    Bmv(1,2) = 0;

    Bmv(2,1) = 0;
    Bmv(2,2) = 0;

    Bmv(3,1) = 1;
    Bmv(3,2) = -(x3-(1-delta*x1));
end