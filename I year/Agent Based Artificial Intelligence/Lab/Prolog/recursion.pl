% facts
parent(richard,ned).
parent(richard,brandon).
parent(richard,lyanna).
parent(ned,arya).
parent(ned,sansa).


% ----------------------------------
% ancestor rule declarations
% ----------------------------------
% base case +
% recursive call with tail recursion
ancestor1(X, Y) :-
    parent(X, Y).

ancestor1(X, Y) :-
    parent(X, Z),
    ancestor1(Z, Y).


% ----------------------------------
% base case +
% recursive call with head recursion
ancestor2(X, Y) :-
    parent(X, Y).

ancestor2(X, Y) :-
    ancestor2(Z, Y),
    parent(X, Z).


% ----------------------------------
% recursive call with tail recursion +
% base case
ancestor3(X, Y) :-
    parent(X, Z),
    ancestor3(Z, Y).

ancestor3(X, Y) :-
    parent(X, Y).


% ----------------------------------
% recursive call with head recursion +
% base case
ancestor4(X, Y) :-
    ancestor4(Z, Y),
    parent(X, Z).

ancestor4(X, Y) :-
    parent(X, Y).


% ----------------------------------
% ----------------------------------
% QUERY: ancestor1(X, Y).
% For debugging: trace, ancestor1(X, Y)
% ----------------------------------

