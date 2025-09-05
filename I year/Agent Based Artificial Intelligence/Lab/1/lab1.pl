% Fatti: proprieta' degli animali domestici
pet(jack, dog, jr, male). %jr sta per Jack Russell
pet(melody, dog, jr, female).
pet(zara, dog, other, female).
pet(diego, dog, other, male).
pet(leo, dog, other, male).
pet(cacco, rabbit, other, female).
pet(lil, rabbit, other, female).
pet(camillo, rabbit, other, male).

% Predicati ausiliari per verificare le proprieta' degli animali
is_dog(P) :- pet(P, dog, _, _).
is_rabbit(P) :- pet(P, rabbit, _, _).
is_jr(P) :- pet(P, _, jr, _).
is_male(P) :- pet(P, _, _, male).
is_female(P) :- pet(P, _, _, female).

% Predicato principale per trovare una soluzione
solve(Areas) :-
    AllPets = [jack, melody, zara, diego, leo, cacco, lil, camillo],

    assign_pets_w_local_checks(AllPets, [], Area1, [], Area2, [], Area3),
    check_jr_together(Area1,Area2,Area3),

    Areas = [Area1,Area2,Area3].

% Caso base: tutti gli animali sono stati assegnati (le aree correnti sono le finali)
assign_pets_w_local_checks([], A1, A1, A2, A2, A3, A3).

% Caso ricorsivo: assegna un animale alla volta
assign_pets_w_local_checks([P|RestPets], CurrentA1, Area1, CurrentA2, Area2, CurrentA3, Area3) :-
    % provo ad assegnare P all'A1
    add_pet_to_area_e_check(P, CurrentA1, NextA1_candidate),
    assign_pets_w_local_checks(RestPets, NextA1_candidate, Area1, CurrentA2, Area2, CurrentA3, Area3)
    ;
    % provo ad assegnare P all'A2
    add_pet_to_area_e_check(P, CurrentA2, NextA2_candidate),
    assign_pets_w_local_checks(RestPets, CurrentA1, Area1, NextA2_candidate, Area2, CurrentA3, Area3)
    ;
    % provo ad assegnare P all'A3
    add_pet_to_area_e_check(P, CurrentA3, NextA3_candidate),
    assign_pets_w_local_checks(RestPets, CurrentA1, Area1, CurrentA2, Area2, NextA3_candidate, Area3).

add_pet_to_area_e_check(Pet, CurrentArea, NextArea) :-
    % verifico compatibilita' diego
    check_compatibility(Pet, CurrentArea),
    % costruisco l'area candidata con il nuovo animale
    append(CurrentArea, [Pet], NextArea_candidate),
    % capacità dell'area
    check_capacity(NextArea_candidate),
    % se tutti i controlli passano unifico la nuova area con la candidata
    NextArea = NextArea_candidate.

check_compatibility(diego, CurrentArea) :-
    \+ (member(ExistPet, CurrentArea), is_male(ExistPet)).

check_compatibility(Pet, CurrentArea) :-
    is_male(Pet),
    member(diego, CurrentArea),
    fail.

check_compatibility(_,_). % tutti gli altri casi sono soddisfatti


check_capacity(Area) :-
    include(is_dog, Area, Dogs),
    include(is_rabbit, Area, Rabbits),
    length(Dogs, NumDogs),
    length(Rabbits, NumRabbits),
    Total is NumDogs + NumRabbits,
    ( NumRabbits >= 1 ->
        Total =< 3
    ;
        NumDogs =< 2
    ).



check_jr_together(A1, A2, A3) :-
    ( (member(jack, A1), member(melody, A1))
    ; (member(jack, A2), member(melody, A2))
    ; (member(jack, A3), member(melody, A3))
    ).


% Per avviare la ricerca di una soluzione da terminale si puo' usare la query:
% ?- solve(Areas).
% (Aggiungendo il ";" dopo una soluzione ti mostra la successiva).

% Ovviamente dopo essere entrati in modalita' giusta, assicurarsi di essere nella cartella del file come directory da terminal VScode e digitare:
% swipl
% Dopo dobbiamo caricare i file (possibile farlo nei due modi seguenti):
% ?- [lab1].
% ?- consult('lab1.pl').