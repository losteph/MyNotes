function dxdt = stateFunc(x,u)
    
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
    dxdt(1) = alpha*mu*((1 - delta*x2)^(gamma-1))*(1-((1 - delta*x2)/x3)) - mu - omega*x1*abs(x1);
    dxdt(2) = x1 + u3;
    dxdt(3) = -(x3 - (1 - delta*x1))*(beta + u2) + u1;
end

