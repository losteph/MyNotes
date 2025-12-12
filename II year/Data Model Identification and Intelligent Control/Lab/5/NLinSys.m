function y_next = NLinSys(y_curr, u_curr)
% NLINSYS Simula un sistema non lineare del primo ordine.
% Equazione: y(k+1) = 0.9*y(k) + 0.1*atan(u(k))
% Tipo: Modello di Hammerstein (NL statica 'atan' in ingresso + filtro lineare)

    y_next = 0.9 * y_curr + 0.1 * atan(u_curr);

end

%% Versione Prof.

% function [y] = NonLinSys(y1, u1)
% % NLINSYS Simula la dinamica del sistema non lineare.
% %
% % INPUT:
% % y1 : Uscita all'istante precedente y(t-1)
% % u1 : Ingresso all'istante precedente u(t-1)
% %
% % OUTPUT:
% % y  : Uscita all'istante corrente y(t)
% %
% % Equazione del sistema:
% % y(t) = 0.9 * y(t-1) + 0.1 * atan(u(t-1))
% %
% % NOTE TEORICHE:
% % - Il termine '0.9 * y1' rappresenta la memoria lineare (polo dominante).
% %   Più questo fattore è vicino a 1, più il sistema è lento.
% % - Il termine 'atan(u1)' rappresenta la NON-LINEARITÀ STATICA in ingresso.
% %   Questo è un classico modello di HAMMERSTEIN (NL -> L).
% 
%     y = 0.1 * atan(u1) + 0.9 * y1;
% 
% return