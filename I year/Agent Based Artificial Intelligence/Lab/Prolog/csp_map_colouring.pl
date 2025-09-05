% environment
adj(wa, nt).
adj(sa, wa).
adj(nt, sa).
adj(nt, q).
adj(sa, q).
adj(q, nsw).
adj(sa, nsw).
adj(nsw, v).
adj(sa, v).

template([wa/_, sa/_, nt/_, q/_, nsw/_, v/_, t/_]).

domain(_, [red, green, blue]).

csp(Result) :-
    template(Result),
    search(Result).

search([]).
search([ Var/Value | Others]) :-
    search(Others),
    domain(Var, D),
    member(Value, D),
    variable_constraint(Var/Value, Others).


member(X, [X|_]).
member(X, [_|T]) :-
    member(X, T).


border(X, Y) :-
    adj(X, Y).
border(X, Y) :-
    adj(Y, X).


color_constraint(_/_, []).
color_constraint(Var/Value, [H |T]) :-
    H = Var2/Value2,
    border(Var, Var2), !,
    Value \= Value2,
    color_constraint(Var/Value, T).
color_constraint(Var/Value, [_ |T]) :-
    color_constraint(Var/Value, T).


variable_constraint(Var/Value, State) :-
    color_constraint(Var/Value, State).



