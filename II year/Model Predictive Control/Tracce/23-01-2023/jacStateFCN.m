function [A, B] = jacStateFCN(x, u, params)
    % Estrazione Parametri (Assicurati che coincidano con quelli del main/stateFCN)
    Ts = params(1);
    
    % Parametri del veicolo (Dalla tabella della traccia)
    L = 3;  
    L1 = 1; 
    L2 = 4; 
    
    % Mappatura stati e ingressi per leggibilità
    % x(1)=x, x(2)=y, x(3)=theta, x(4)=beta
    theta = x(3);
    beta = x(4);
    
    % u(1)=v, u(2)=alpha
    v = u(1);
    alpha = u(2);
    
    % --- MATRICE A (Jacobiano rispetto agli stati 4x4) ---
    A = zeros(4,4);
    
    % Riga 1 (x)
    A(1,1) = 1;
    A(1,3) = -Ts*v*sin(theta)*((L1*tan(alpha)*tan(beta))/L + 1);
    A(1,4) = (L1*Ts*v*tan(alpha)*cos(theta)*(tan(beta)^2 + 1))/L;
    
    % Riga 2 (y)
    A(2,2) = 1;
    A(2,3) = Ts*v*cos(theta)*((L1*tan(alpha)*tan(beta))/L + 1);
    A(2,4) = (L1*Ts*v*tan(alpha)*sin(theta)*(tan(beta)^2 + 1))/L;
    
    % Riga 3 (theta)
    A(3,3) = 1;
    
    % Riga 4 (beta)
    % Nota: cos(beta-theta) è pari, quindi cos(theta-beta) è uguale.
    A(4,3) = (Ts*v*cos(beta - theta))/L2; 
    A(4,4) = 1 - (Ts*v*cos(beta - theta))/L2;

    
    % --- MATRICE B (Jacobiano rispetto agli ingressi 4x2) ---
    B = zeros(4,2);
    
    % Riga 1 (x)
    B(1,1) = Ts*cos(theta)*((L1*tan(alpha)*tan(beta))/L + 1);
    B(1,2) = (L1*Ts*v*tan(beta)*cos(theta)*(tan(alpha)^2 + 1))/L;
    
    % Riga 2 (y)
    B(2,1) = Ts*sin(theta)*((L1*tan(alpha)*tan(beta))/L + 1);
    B(2,2) = (L1*Ts*v*tan(beta)*sin(theta)*(tan(alpha)^2 + 1))/L;
    
    % Riga 3 (theta)
    B(3,1) = (Ts*tan(alpha))/L;
    B(3,2) = (Ts*v*(tan(alpha)^2 + 1))/L;
    
    % Riga 4 (beta)
    B(4,1) = -(Ts*sin(beta - theta))/L2;
    B(4,2) = 0;

end