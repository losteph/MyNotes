% La rete di voli
volo(roma, parigi).
volo(roma, berlino).

volo(parigi, londra).
volo(berlino, londra).

% Attenzione: ciclo!
volo(londra, parigi).

% --- 1. PREDICATO PRINCIPALE (quello che chiami tu) ---
%
% trova_rotta(Da, A, Rotta)
% Chiama l'helper 'search' per fare il lavoro sporco.
% Inizia la lista dei 'Visitati' con la città di partenza 'Da'.
trova_rotta(Da, A, Rotta) :-
    % 'search' ci darà la rotta al contrario (es. [londra, parigi, roma])
    search(Da, A, [Da], RottaRovesciata),
    
    % Quindi invertiamo il risultato per l'output finale
    reverse(RottaRovesciata, Rotta).


% --- 2. PREDICATO HELPER (il motore ricorsivo) ---
%
% search(StatoCorrente, Fine, Visitati, Risultato)

% Caso Base: Siamo arrivati!
% Se lo StatoCorrente è la Fine, il nostro Risultato
% è semplicemente la lista dei Visitati che abbiamo accumulato.
search(Fine, Fine, Visitati, Visitati).

% Passo Ricorsivo: Continua la ricerca
search(StatoCorrente, Fine, Visitati, Risultato) :-
    
    % 1. Trova un volo che parte da dove siamo
    volo(StatoCorrente, ProssimaCitta),
    
    % 2. VINCOLO ANTI-CICLO (Il passo più importante!)
    % Controlla che la ProssimaCitta NON sia già nella lista Visitati
    \+ member(ProssimaCitta, Visitati),
    
    % 3. Se è una città nuova, continua la ricerca da lì,
    % aggiungendo ProssimaCitta alla lista dei Visitati.
    search(ProssimaCitta, Fine, [ProssimaCitta | Visitati], Risultato).


% --- 3. PREDICATO HELPER (member/2, se non fosse integrato) ---

member(X, [X|_]).
member(X, [_|T]) :- member(X, T).
