function u = aprbs(N, Tmin, Tmax, Vmin, Vmax)
% APRBS Genera un segnale Pseudo-Random Binary Sequence modulato in ampiezza.
% N: Numero di campioni totali
% Tmin, Tmax: Durata minima e massima di ogni step (in campioni)
% Vmin, Vmax: Valori minimo e massimo dell'ampiezza

    u = [];
    while length(u) < N
        % Durata casuale del prossimo gradino
        L = round(Tmin + (Tmax - Tmin) * rand(1));
        
        % Ampiezza casuale del prossimo gradino
        val = Vmin + (Vmax - Vmin) * rand(1);
        
        % Concatenazione
        u = [u, val * ones(1, L)];
    end
    
    % Taglio alla lunghezza esatta N
    u = u(1:N);
end

%% Versione Prof.

% function u = aprbs(N, Tmin, Tmax, Vmin, Vmax)
% % APRBS Genera un segnale Pseudo-Random Binary Sequence modulato in ampiezza.
% %
% % INPUT:
% % N           : Numero totale di campioni da generare
% % Tmin, Tmax  : Durata minima e massima di ogni gradino (in campioni)
% % Vmin, Vmax  : Valore minimo e massimo dell'ampiezza del gradino
% %
% % OUTPUT:
% % u           : Vettore riga contenente il segnale generato
% 
%     % 1. Generazione del primo blocco
%     % Calcola una durata casuale L tra Tmin e Tmax
%     L = round(Tmin + (Tmax - Tmin) * rand(1));
% 
%     % Calcola un'ampiezza casuale e crea il primo pezzo di segnale
%     u = (Vmin + (Vmax - Vmin) * rand(1)) * ones(1, L);
% 
%     % Inizializza il contatore dei campioni generati
%     i = L;
% 
%     % 2. Ciclo per riempire il resto del vettore fino a N
%     while(i < N)
%         % Calcola la durata del prossimo gradino
%         L = round(Tmin + (Tmax - Tmin) * rand(1));
% 
%         % Controllo per non sforare la lunghezza N:
%         if (i + L) <= N
%             % Se ci stiamo dentro, generiamo un gradino di lunghezza L
%             q = (Vmin + (Vmax - Vmin) * rand(1)) * ones(1, L);
%         else
%             % Se sforiamo, generiamo solo i campioni mancanti (N - i)
%             q = (Vmin + (Vmax - Vmin) * rand(1)) * ones(1, N - i);
%         end
% 
%         % Concateniamo il nuovo pezzo al vettore u esistente
%         u = [u q];
% 
%         % Aggiorniamo il contatore
%         i = i + L;
%     end
% end