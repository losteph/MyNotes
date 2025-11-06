% --- FATTI ---
% studente(Nome, Anno, Specializzazione)
studente(ada, primo, chimica).
studente(leo, secondo, fisica).
studente(mia, primo, chimica).
studente(nico, secondo, fisica).
studente(pio, secondo, fisica).

solve(S) :-
    Laboratorio = [lab_a, lab_b]
    
    member(LabAda, Laboratorio),
    member(LabLeo, Laboratorio),
    member(LabMia, Laboratorio),
    member(LabNico, Laboratorio),
    member(LabPio, Laboratorio),
    
    S = [assegna(ada, LabAda),
         assegna(leo, LabLeo),
         assegna(mia, LabMia),
         assegna(pio, LabPio),
         assegna(nico, LabNico),
        ],
    
    

    LabLeo = LabNico,
    LabNico = LabPio,
    LabAda \= LabMia
    
    % Contiamo quelli in Lab A
    findall(S, member(assegna(S, lab_a), Assegnazioni), StudentiInA),
    length(StudentiInA, NumA),
    NumA =< 3,
    
    % Contiamo quelli in Lab B
    findall(S, member(assegna(S, lab_b), Assegnazioni), StudentiInB),
    length(StudentiInB, NumB),
    NumB =< 3.
    
