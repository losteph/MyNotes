function x_next = stateFCN(x, u, params)
    % Stati: x(1)=x, x(2)=y, x(3)=theta, x(4)=beta
    % Ingressi: u(1)=v, u(2)=alpha (steering)
    
    % Estrazione Parametri
    Ts = params(1);
    L = 3;  % Esempio (inserire valori tabella traccia)
    L1 = 1; 
    L2 = 4; 
    
    % Variabili di comodo
    theta = x(3);
    beta = x(4);
    v = u(1);
    alpha = u(2);
    
    % Termine di accoppiamento (dalla traccia)
    % Assicurati che corrisponda esattamente all'immagine del PDF
    coupling = (1 + (L1/L)*tan(beta)*tan(alpha));
    
    % Equazioni differenziali (f)
    x_dot = v * cos(theta) * coupling;
    y_dot = v * sin(theta) * coupling;
    theta_dot = (v/L) * tan(alpha);
    beta_dot = (v/L2) * sin(theta - beta); 
    
    % Discretizzazione Eulero: x(k+1) = x(k) + x_dot * Ts
    x_next = x + [x_dot; y_dot; theta_dot; beta_dot] * Ts;
end