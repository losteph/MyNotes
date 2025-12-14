function x_next = stateFCN(x, u, params)
    % STATI: x(1)=P, x(2)=Q, x(3)=H
    % INGRESSI: u(1)=u_P, u(2)=u_Q
    
    % Estrazione parametri
    Ts = params(1);
    alpha = 0.1;
    beta  = 0.5;
    gamma = 0.2;
    
    % Variabili di stato correnti
    P = x(1);
    Q = x(2);
    H = x(3);
    
    % Ingressi
    uP = u(1);
    uQ = u(2);
    
    % Equazioni Differenziali (dalla traccia)
    P_dot = alpha * (uP - P) + beta * Q;
    Q_dot = gamma * (uQ - Q);
    H_dot = beta * Q^2; % Non linearità
    
    % Discretizzazione Eulero
    x_next = zeros(3,1);
    x_next(1) = P + P_dot * Ts;
    x_next(2) = Q + Q_dot * Ts;
    x_next(3) = H + H_dot * Ts;
end