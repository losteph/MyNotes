% Stato: state(MaxPos, MinPos, MaxScore, VisitedSpecials, Player).
% Posizione: pos(R,C).

% --- Configurazione ---
board_size(4).
max_depth(10).
special_cells([ pos(1,1), pos(2,2), pos(0,3), pos(3,0) ]).
total_special_cells(4).

% --- Utility di base ---
manhattan_distance(pos(R1,C1), pos(R2,C2), Dist) :-
    Dist is abs(R1 - R2) + abs(C1 - C2).

move(pos(R,C), N, pos(NewR,NewC)) :-
    member((DR,DC), [(-1,0),(1,0),(0,-1),(0,1)]),
    NewR is R + DR, NewC is C + DC,
    NewR >= 0, NewR < N,
    NewC >= 0, NewC < N.

% --- Risultato di una mossa di MAX ---
max_result(state(_MaxPos, MinPos, Score, Visited, max), ActionPos,
           state(ActionPos, MinPos, NewScore, NewVisited, min), SpecialCells) :-
    ( member(ActionPos, SpecialCells),
      \+ member(ActionPos, Visited) ->
        NewScore is Score + 1,
        NewVisited = [ActionPos | Visited]
    ;
        NewScore = Score,
        NewVisited = Visited
    ).

% --- Risultato di una mossa di MIN ---
min_result(state(MaxPos, _MinPos, Score, Visited, min), ActionPos,
           state(MaxPos, ActionPos, Score, Visited, max)).

% --- Terminal test ---
terminal_test(state(MaxPos, MinPos, Score, _Visited, _Player), _SpecialCells, _N, TotalSpecial) :-
    ( MaxPos = MinPos ; Score >= TotalSpecial ).

% --- Funzione di utilità ---
utility(state(MaxPos, MinPos, Score, _Visited, _Player), _N, UtilityValue, TotalSpecial) :-
    ( MaxPos = MinPos ->
        UtilityValue is -1000
    ; Score >= TotalSpecial ->
        UtilityValue is 1000
    ;
        manhattan_distance(MaxPos, MinPos, Dist),
        UtilityValue is Dist
    ).

% ==========================
% MINIMAX (con cut-off)
% ==========================
% caso base: terminale o cut-off
minimax_value(State, Depth, _MaxDepth, SpecialCells, N, TotalSpecial, Value) :-
    ( terminal_test(State, SpecialCells, N, TotalSpecial) ; Depth =< 0 ),
    utility(State, N, Value, TotalSpecial), !.

% MAX tocca
minimax_value(state(MaxPos, MinPos, Score, Visited, max), Depth, MaxDepth, SpecialCells, N, TotalSpecial, BestValue) :-
    Depth > 0,
    D1 is Depth - 1,
    findall(V, (
        move(MaxPos, N, Action),
        max_result(state(MaxPos, MinPos, Score, Visited, max), Action, NewState, SpecialCells),
        minimax_value(NewState, D1, MaxDepth, SpecialCells, N, TotalSpecial, V)
    ), Values),
    ( Values == [] ->
        utility(state(MaxPos, MinPos, Score, Visited, max), N, BestValue, TotalSpecial)
    ;
        max_list(Values, BestValue)
    ).

% MIN tocca
minimax_value(state(MaxPos, MinPos, Score, Visited, min), Depth, MaxDepth, SpecialCells, N, TotalSpecial, BestValue) :-
    Depth > 0,
    D1 is Depth - 1,
    findall(V, (
        move(MinPos, N, Action),
        min_result(state(MaxPos, MinPos, Score, Visited, min), Action, NewState),
        minimax_value(NewState, D1, MaxDepth, SpecialCells, N, TotalSpecial, V)
    ), Values),
    ( Values == [] ->
        utility(state(MaxPos, MinPos, Score, Visited, min), N, BestValue, TotalSpecial)
    ;
        min_list(Values, BestValue)
    ).

% ==========================
% ALPHA-BETA PRUNING
% ==========================
% caso base alpha-beta
alpha_beta_value(State, Depth, _MaxDepth, _Alpha, _Beta, SpecialCells, N, TotalSpecial, Value) :-
    ( terminal_test(State, SpecialCells, N, TotalSpecial) ; Depth =< 0 ),
    utility(State, N, Value, TotalSpecial), !.

% se tocca MAX
alpha_beta_value(state(MaxPos, MinPos, Score, Visited, max), Depth, MaxDepth, Alpha, Beta, SpecialCells, N, TotalSpecial, BestValue) :-
    Depth > 0,
    findall(Action, move(MaxPos, N, Action), Moves),
    alpha_beta_max(Moves, state(MaxPos, MinPos, Score, Visited, max), Depth, MaxDepth, Alpha, Beta, SpecialCells, N, TotalSpecial, BestValue).

% se tocca MIN
alpha_beta_value(state(MaxPos, MinPos, Score, Visited, min), Depth, MaxDepth, Alpha, Beta, SpecialCells, N, TotalSpecial, BestValue) :-
    Depth > 0,
    findall(Action, move(MinPos, N, Action), Moves),
    alpha_beta_min(Moves, state(MaxPos, MinPos, Score, Visited, min), Depth, MaxDepth, Alpha, Beta, SpecialCells, N, TotalSpecial, BestValue).

% helper MAX con potatura
alpha_beta_max([], State, _Depth, _MaxDepth, _Alpha, _Beta, _Special, N, TotalSpecial, Value) :-
    utility(State, N, Value, TotalSpecial).

alpha_beta_max([Action|Rest], State, Depth, MaxDepth, Alpha, Beta, Special, N, TotalSpecial, BestValue) :-
    max_result(State, Action, NewState, Special),
    D1 is Depth - 1,
    alpha_beta_value(NewState, D1, MaxDepth, Alpha, Beta, Special, N, TotalSpecial, Val),
    ( Val >= Beta ->
        BestValue = Val  % beta cut-off
    ;
        NewAlpha is max(Alpha, Val),
        alpha_beta_max(Rest, State, Depth, MaxDepth, NewAlpha, Beta, Special, N, TotalSpecial, BestRest),
        MaxVal is max(Val, BestRest),
        BestValue = MaxVal
    ).

% helper MIN con potatura
alpha_beta_min([], State, _Depth, _MaxDepth, _Alpha, _Beta, _Special, N, TotalSpecial, Value) :-
    utility(State, N, Value, TotalSpecial).

alpha_beta_min([Action|Rest], State, Depth, MaxDepth, Alpha, Beta, Special, N, TotalSpecial, BestValue) :-
    min_result(State, Action, NewState),
    D1 is Depth - 1,
    alpha_beta_value(NewState, D1, MaxDepth, Alpha, Beta, Special, N, TotalSpecial, Val),
    ( Val =< Alpha ->
        BestValue = Val  % alpha cut-off
    ;
        NewBeta is min(Beta, Val),
        alpha_beta_min(Rest, State, Depth, MaxDepth, Alpha, NewBeta, Special, N, TotalSpecial, BestRest),
        MinVal is min(Val, BestRest),
        BestValue = MinVal
    ).

% ==========================
% Trova la migliore mossa per MAX (root)
% ==========================
% rappresentiamo coppie con pair(Value,Action) per evitare ambiguita' con '-'
best_pair([P], P).
best_pair([pair(V,A)|Rest], Best) :-
    best_pair(Rest, pair(V2,A2)),
    ( V > V2 -> Best = pair(V,A) ; Best = pair(V2,A2) ).

find_best_move(InitialState, BestAction, UseAlphaBeta) :-
    board_size(N),
    max_depth(MaxDepth),
    special_cells(SC),
    total_special_cells(TSC),
    InitialState = state(MaxPos, _MinPos, _Score, _Visited, max),

    ( UseAlphaBeta == true ->
        findall(pair(Value,Action), (
            move(MaxPos, N, Action),
            max_result(InitialState, Action, NewState, SC),
            D1 is MaxDepth - 1,
            alpha_beta_value(NewState, D1, MaxDepth, -1000000, 1000000, SC, N, TSC, Value)
        ), Pairs),
        ( Pairs = [] ->
            writeln('No moves for MAX (alpha-beta)'), fail
        ;
            best_pair(Pairs, pair(BestValue, BestAction)),
            format("Migliore mossa per MAX (alpha-beta): ~w con utilita ~w~n", [BestAction, BestValue])
        )
    ;
        % minimax
        findall(pair(Value,Action), (
            move(MaxPos, N, Action),
            max_result(InitialState, Action, NewState, SC),
            D1 is MaxDepth - 1,
            minimax_value(NewState, D1, MaxDepth, SC, N, TSC, Value)
        ), Pairs),
        ( Pairs = [] ->
            writeln('No moves for MAX (minimax)'), fail
        ;
            best_pair(Pairs, pair(BestValue, BestAction)),
            format("Migliore mossa per MAX (minimax): ~w con utilita ~w~n", [BestAction, BestValue])
        )
    ).

% Stato iniziale (ad esempio):
initial_state(state(pos(0,0), pos(3,3), 0, [], max)).

% Esempi di query:
% ?- initial_state(S), find_best_move(S, BestAct, false).  % minimax
% ?- initial_state(S), find_best_move(S, BestAct, true).   % alpha-beta
