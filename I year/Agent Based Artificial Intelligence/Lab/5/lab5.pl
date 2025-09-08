:- use_module(library(lists)).

% --- Tempi di attraversamento ---
time(antonio, 40).
time(claudio, 80).
time(felice, 100).
time(walter, 20).

% --- Stato: state(LatoSinistro, LatoDestro, LatoTorcia, TempoTotale) ---
% canonical_state per ordinare le liste ed evitare duplicati
canonical_state(state(L, R, Side, T), state(SL, SR, Side, T)) :-
    sort(L, SL),
    sort(R, SR).

% --- Tempo di attraversamento di un gruppo ---
group_time([P], T) :- time(P, T).
group_time([P1,P2], T) :-
    time(P1, T1),
    time(P2, T2),
    T is max(T1, T2).

% --- Mosse possibili ---

% Attraversamento (da sinistra a destra): 1 o 2 persone
move(state(Left, Right, left, CurT),
     Next,
     move_step(cross, People, DT)) :-
    ( select(P, Left, NewLeft), People = [P], RemLeft = NewLeft
    ; select(P1, Left, Tmp), select(P2, Tmp, RemLeft),
      P1 @< P2, People = [P1,P2]
    ),
    group_time(People, DT),
    NextT is CurT + DT, NextT =< 240,
    append(Right, People, NewRight),
    canonical_state(state(RemLeft, NewRight, right, NextT), Next).

% Ritorno (da destra a sinistra): 1 persona sola
move(state(Left, Right, right, CurT),
     Next,
     move_step(return, [P], DT)) :-
    select(P, Right, NewRight),
    group_time([P], DT),
    NextT is CurT + DT, NextT =< 240,
    append(Left, [P], NewLeft),
    canonical_state(state(NewLeft, NewRight, left, NextT), Next).

% --- Stato goal: tutti a destra, tempo <= 240 ---
goal(state([], Right, _, T)) :-
    length(Right, 4),
    T =< 240.

% --- Ricerca DFS con accumulo delle mosse ---
solve(State, _, Acc, Moves, T) :-
    goal(State),
    State = state(_, _, _, T),
    reverse(Acc, Moves).

solve(State, Visited, Acc, Moves, T) :-
    move(State, Next, Step),
    \+ member(Next, Visited),
    solve(Next, [Next|Visited], [Step|Acc], Moves, T).

% --- Trova tutte le soluzioni (ordinate per tempo) ---
find_all_solutions(Solutions) :-
    InitialPeople = [antonio, claudio, felice, walter],
    Initial = state(InitialPeople, [], left, 0),
    canonical_state(Initial, Canonical),
    findall((T, Moves),
            solve(Canonical, [Canonical], [], Moves, T),
            Raw),
    sort(1, @=<, Raw, Solutions).

% --- Stampa leggibile ---
print_all_solutions(Solutions) :-
    length(Solutions, N),
    format('\nTrovate ~w soluzioni valide:\n', [N]),
    print_solutions(1, Solutions).

print_solutions(_, []).
print_solutions(I, [(T, Moves)|Rest]) :-
    format('\n--- Soluzione ~w (Tempo totale: ~w s) ---\n', [I, T]),
    print_moves(1, Moves),
    I1 is I + 1,
    print_solutions(I1, Rest).

print_moves(_, []).
print_moves(N, [move_step(cross, People, DT)|Rest]) :-
    format(' Passo ~w: ATTRAVERSANO ~w (impiegati ~w s)\n', [N, People, DT]),
    N1 is N + 1,
    print_moves(N1, Rest).
print_moves(N, [move_step(return, [P], DT)|Rest]) :-
    format(' Passo ~w: RITORNA ~w (impiegati ~w s)\n', [N, P, DT]),
    N1 is N + 1,
    print_moves(N1, Rest).


% query da terminale per eseguire il programma:
% ?- find_all_solutions(S), print_all_solutions(S).