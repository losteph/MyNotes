% Dati 
num_container(4).
max_capacity_container(6).

% Categorie articoli
item_category(t1, trash).
item_category(t2, trash).
item_category(t3, trash).
item_category(t4, trash).
item_category(t5, trash).
item_category(f1, food).
item_category(f2, food).
item_category(f3, food).
item_category(e1, explosive).
item_category(e2, explosive).
item_category(fz1, frozen).
item_category(fz2, frozen).
item_category(fz3, frozen).
item_category(fs1, fresh).

all_items(Items) :-
    findall(Item, item_category(Item,_), Items).

% Articoli esplosivi in contenitori diversi tra loro
e_different(Assignment) :-
    member(e1-ContainerE1, Assignment),
    member(e2-ContainerE2, Assignment),
    ContainerE1 \= ContainerE2.

% Trash e Food non possono stare insieme
tf_different(Assignment) :-
    forall( (item_category(TrashItem, trash), item_category(FoodItem, food)),
            ( member(TrashItem-ContainerT, Assignment),
              member(FoodItem-ContainerF, Assignment),
              ContainerF \= ContainerT
            )
    ).


% Fresh e Frozen non possono stare insieme
fzfs_different(Assignment) :-
    forall(
        (item_category(FreshItem, fresh), item_category(FrozenItem, frozen)),
        (
            member(FrozenItem-ContainerFz, Assignment),
            member(FreshItem-ContainerFs, Assignment),
            ContainerFs \= ContainerFz
        )
    ).

% Tutti gli oggetti congelati devono stare insieme
fz_same(Assignment) :-
    member(fz1-ContainerFz, Assignment),
    member(fz2-ContainerFz, Assignment),
    member(fz3-ContainerFz, Assignment).


% Capacità massima
capacity_ok(Assignment) :-
    num_container(NumC),
    max_capacity_container(MaxC),
    forall(between(1, NumC, ContainerID),
    (
        findall(Item, member(Item-ContainerID, Assignment), ItemsInContainer),
        length(ItemsInContainer, Count),
        Count =< MaxC
    )).

% solver
solve(Assignment) :-
    all_items(Items),
    num_container(NumC),
    generate_assignment(Items, NumC, Assignment),
    e_different(Assignment),
    tf_different(Assignment),
    fzfs_different(Assignment),
    fz_same(Assignment),
    capacity_ok(Assignment).

% helper per generare l'assegnazione
generate_assignment([],_,[]).
generate_assignment([Item|RestItem], NumC, [Item-ContainerID|RestAssignment]) :-
    between(1, NumC, ContainerID), % ContainerID sarà istanziato da 1 a NumC per ogni articolo
    generate_assignment(RestItem, NumC, RestAssignment).


% Per risolvere usiamo la query:
% ?- solve(Solution).