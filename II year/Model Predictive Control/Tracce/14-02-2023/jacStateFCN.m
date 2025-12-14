function [A, B] = jacStateFCN(x, u, params)
    Ts = params(1);
    alpha = 0.1;
    beta  = 0.5;
    gamma = 0.2;
    
    % Stato corrente necessario per la derivata
    Q = x(2);
    
    % --- MATRICE A (3x3) ---
    % Diagonale principale: 1 + derivata*Ts
    A = zeros(3,3);
    
    % Riga 1 (P)
    A(1,1) = 1 + (-alpha) * Ts; 
    A(1,2) = beta * Ts;

    % Riga 2 (Q)
    A(2,2) = 1 + (-gamma) * Ts;
    
    % Riga 3 (H)
    % Derivata di (beta*Q^2) rispetto a Q è (2*beta*Q)
    A(3,2) = (2 * beta * Q) * Ts; 
    A(3,3) = 1; % Derivata rispetto a H è 0, quindi resta 1 dell'integratore
    
    
    % --- MATRICE B (3x2) ---
    % Derivate rispetto agli ingressi uP, uQ
    B = zeros(3,2);
    
    % Riga 1 (P): dipende da uP con guadagno alpha
    B(1,1) = alpha * Ts;
    
    % Riga 2 (Q): dipende da uQ con guadagno gamma
    B(2,2) = gamma * Ts;
    
    % Riga 3 (H): non dipende direttamente dagli ingressi
    % (dipende solo da Q che è uno stato)
end