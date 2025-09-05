template([v1/_, v2/_, v3/_]).

domain(v1, [1,2,3,4]).
domain(v2, [3,4,5,6]).
domain(v3, [4,7,8,9]).


csp(Solution) :-
    template(Solution),
    search(Solution).

search([]).
search([ H | Other]) :-
    search(Other),
    H = Var/Value,
    domain(Var, Domain),
    member(Value, Domain),
    variable_contraint(Var/Value, Other),
    global_constraint(Var/Value, Other).


member(X, [X | _]).
member(X, [_ | T]):-
    member(X, T).


all_equals([]).
all_equals([_]) :- !.
all_equals([H | [H1 | T]]) :-
    H = _/Value,
    H1 = _/Value1,
	Value == Value1, !,
    all_equals([H1 | T]).
          

variable_contraint(v1/Value, State) :-
    !,
    fixed_value(v1/Value, 3),
    same_value(v1/Value, v2, State).
               
variable_contraint(v2/Value, State) :-
    !,
    same_value(v2/Value, v1, State).
               
variable_contraint(_/_, _).

fixed_value(_/Value, FixedValue) :-
    Value == FixedValue.
             
             
same_value(_/Value, Var2, State) :-
    % check if Var2 has been already assigned
    var_in_state(Var2, State, Value2), 
    !,
    Value == Value2.
same_value(_/_, _, _).           
             
var_in_state(Var, [Var/Value | _], Value) :- !.
var_in_state(Var, [_ | T], Value) :-
    var_in_state(Var, T, Value).



% check if all the variables have been assigned
state_length([], 0) :- !.
state_length([_ | T], Length) :-
    state_length(T, TailLength),
    Length is TailLength + 1.

values_sum([_/Value], Value).
values_sum([_/Value | T], Sum) :-
    values_sum(T, TailSum),
    Sum is TailSum + Value.

sum_constraint(State, Limit) :-
    state_length(State, 3),
    !,
    values_sum(State, Sum),
    Sum > Limit.
sum_constraint(_, _).

global_constraint(Var/Value, State) :-
    sum_constraint( [Var/Value | State], 13).




             
             
             
             
