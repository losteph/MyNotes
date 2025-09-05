template([1/Y1, 2/Y2, 3/Y3, 4/Y4]).

solution([]).
solution([H| Others]) :-
    solution(Others),
    H = _/Y,
    member(Y, [1,2,3,4]),
    different_rows(H, Others),
    different_diagonal(H, Others).

different_rows( _/_, []).
different_rows( Q/Y, [_/Y1 | RemainingQueens] ) :-
    Y =\= Y1,
    different_rows( Q/Y, RemainingQueens ).

different_diagonal(_/_, []).
different_diagonal( Q/Y, [Q1/Y1 | RemainingQueens] ) :-
    Y1 - Y =\= Q - Q1,
    Y1 - Y =\= Q1 - Q,
    different_diagonal( Q/Y, RemainingQueens ).

noattack(_/_, []).
noattack( Q/Y, [Q1/Y1 | RemainingQueens] ) :-
	Y =\= Y1,
    Y1 - Y =\= Q - Q1,
    Y1 - Y =\= Q1 - Q,
    noattack( Q/Y, RemainingQueens ).
               
               
member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).








