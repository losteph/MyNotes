% a-- > b
% ^    / 
% |   /
% | L
% c ---> d


arc(a, b).
arc(b, c).
arc(c, d).
arc(c, a).

inverse_arc(Y, X) :-
    arc(X, Y).

generic_arc(X, Y) :-
    arc(X,Y);
    inverse_arc(X,Y).

path(X, Y) :-
    generic_arc(X, Y).

path(X, Y) :-
    generic_arc(X, Z),
    path(Z, Y).


% Try asking Prolog
% 
% ?- path(a, d) is entailed by the KB
% ?- path(d, a) is entailed by the KB
% ?- path(a, a) is entailed by the KB
% ?- path(a, c) is entailed by the KB 
% ?- path(c, b) is entailed by the KB 
% ?- path(d, b) is entailed by the KB 
% ?- path(d, c) is entailed by the KB 

