% a-- > b
% ^    / 
% |   /
% | L
% c ---> d


arc(a, b).
arc(b, c).
arc(c, d).
arc(c, a).

% inverse arc definition
%arc(X, Y) :-
%   arc(Y, X).

path(X, Y) :-
    arc(X, Y).

path(X, Y) :-
    arc(X, Z),
    path(Z, Y).

% When inverse arc COMMENTED
% 
% ?- path(a, d) is entailed by the KB
% ?- path(d, a) is NOT entailed by the KB
% ?- path(a, a) is entailed by the KB
% ?- path(a, c) is entailed by the KB 
% ?- path(c, b) is entailed by the KB 
% ?- path(d, b) is NOT entailed by the KB 
% ?- path(d, c) is NOT entailed by the KB 
% That because arcs are directed!


% Now UNCOMMENT the inverse arc definition
% 
% ?- path(d, c) is entailed by the KB
% ?- path(c, b) is entailed by the KB
% ?- path(a, d) LOOPS! Can you see why?
% try asking Prolog
% ?- trace, path(a, d)
