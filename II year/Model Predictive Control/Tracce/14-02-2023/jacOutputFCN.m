function [C, D] = jacOutputFCN(x, u, params)
    % C è la derivata dell'uscita rispetto agli stati (ny x nx)
    % D è la derivata dell'uscita rispetto agli ingressi (ny x nu)
    
    % Essendo y = x (3 uscite, 3 stati) -> Matrice Identità 3x3
    C = eye(3); 
    
    % L'uscita non dipende direttamente dall'ingresso u -> Zeri
    D = zeros(3,2); 
end