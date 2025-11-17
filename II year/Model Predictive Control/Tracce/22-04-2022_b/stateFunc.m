function dxdt = stateFunc(x,u)
    fr = 4870;
    pr = 1485;

    alpha = 5.098;
    gamma = 5.257;
    mu    = 0.1961;
    omega = 8.544;
    delta = 0.0255;
    beta  = 0.01683;
    
    % States
    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
   
    % Inputs
    u1 = u(1);
    u2 = u(2);
    u3 = u(3);

    dxdt = zeros(3,1);
    dxdt(1) = -(x1 - (1 - delta*x3))*(beta + u2/pr) + u1/fr;
    dxdt(2) = alpha*mu*((1 - delta*x3)^(gamma-1))*(1-((1 - delta*x3)/x1)) - mu -omega*x2*abs(x2);
    dxdt(3) = x2 + u3;
end

