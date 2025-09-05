% parent
parent(pam, bob).	% Pam is a parent of Bob
parent(tom, bob).
parent(tom, liz).
parent(bob, ann).
parent(bob, pat).
parent(pat, jim).

% sex
female(pam).		% Pam is female
female(liz).
female(ann).
female(pat).
male(bob).		% Bob is male
male(jim).

% parents
mother(X, Y) :-		% X is mother of Y
  parent(X, Y),
  female(X).
father(X, Y) :-		% X is father of Y
    parent(X, Y),
    male(X).

% grandparents
grandparent(X, Y) :-	% X is grandparent of Y
  parent(X, Z),
  parent(Z, Y). 

grandmother(X, Y) :-	% X is grandmother of Y
    grandparent(X, Y),
    female(X).

grandfather(X, Y) :-	% X is grandfather of Y
    grandparent(X, Y),
    male(X).

% siblings
sibling(X, Y) :-	% X and Y are siblings
  parent(Z, X),
  parent(Z, Y),
  X \= Y.

sister(X, Y) :-		% X is sister of Y
  sibling(X, Y),
  female(X).

brother(X, Y) :-	% X is brother of Y
  sibling(X, Y),
  male(X).

% ancestor
ancestor(X, Z) :-	% rule 1 anchestor
  parent(X, Z).

ancestor(X, Z) :-	% rule 2 anchestor
  parent(X, Y),
  ancestor(Y, Z).