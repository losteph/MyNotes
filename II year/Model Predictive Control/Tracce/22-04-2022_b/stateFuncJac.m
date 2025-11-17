function [A,Bmv] = stateFuncJac(x,u)
    alpha = 5.098;
    gamma = 5.257;
    mu    = 0.1961;
    omega = 8.544;
    delta = 0.0255;
    beta  = 0.01683;
    fr = 4870;
    pr = 1485;

    % utils
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
   
    % Get inputs
    u1 = u(1);
    u2 = u(2);
    
    A = zeros(3,3);
    Bmv = zeros(3,2);

    A(1,1) = - beta - u2;
    A(1,3) = -delta*(beta + u2);

    A(2,1) = -(alpha*mu*(delta*x3 - 1)*(1 - delta*x3)^(gamma - 1))/x1^2;
    A(2,2) = - omega*abs(x2) - omega*x2*sign(x2);
    A(2,3) = (alpha*delta*mu*(1 - delta*x3)^(gamma - 1))/x1 - alpha*delta*mu*((delta*x3 - 1)/x1 + 1)*(1 - delta*x3)^(gamma - 2)*(gamma - 1);

    A(3,2) = 1;

    Bmv(1,1) = 1/fr;
    Bmv(1,2) = -(x1 + delta*x3 - 1)/pr;
end