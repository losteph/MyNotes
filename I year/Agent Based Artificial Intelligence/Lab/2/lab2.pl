% Caso base: spostare un solo disco
hanoi(1, Source, Destination, _) :-
    write("sposta disco 1 da: "), write(Source), write(" a "), write(Destination), nl.

% Caso ricorsivo: N dischi
hanoi(N, Source, Destination, Auxiliary) :-
    N > 1,
    N1 is N - 1,
    hanoi(N1, Source, Auxiliary, Destination),
    write("sposta disco "), write(N), write(" da "), write(Source), write(" a "), write(Destination), nl,
    hanoi(N1, Auxiliary, Destination, Source).

% Per eseguire la query:
% ?- hanoi(3, a, c, b).

% Ovviamente devi aver visto lab1 e sapere come caricare il programma prima di eseguirlo.
% L'output atteso, come da suggerimento mostra la sequenza ottimale di 7 mosse per risolvere il puzzle (se n=3)