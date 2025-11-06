% --- Base di Conoscenza ---
% dog(Nome)
dog(jack).
dog(melody).
dog(zara).
dog(diego).
dog(leo).

% rabbit(Nome)
rabbit(cacco).
rabbit(lil).
rabbit(camillo).

% male(Nome)
male(jack).
male(diego).
male(leo).
male(camillo).

% female(Nome)
female(melody).
female(zara).
female(cacco).
female(lil).

% jack_russell(Nome)
jack_russell(jack).
jack_russell(melody).

% Lista di tutti gli animali per comodità
animale(jack).
animale(melody).
animale(zara).
animale(diego).
animale(leo).
animale(cacco).
animale(lil).
animale(camillo).

% --- Solver ---
solve(Soluzione) :-
    
    % 1. GENERA: Assegna a ogni animale un'area [1, 2, 3]
    % (A_jm è la stessa per Jack e Melody, per il Vincolo 2)
    Aree = [1, 2, 3],
    member(A_jm, Aree),     % Area per Jack e Melody
    member(A_zara, Aree),
    member(A_diego, Aree),
    member(A_leo, Aree),
    member(A_cacco, Aree),
    member(A_lil, Aree),
    member(A_camillo, Aree),

    % Crea la struttura della soluzione
    Soluzione = [ pet(jack, A_jm),
                  pet(melody, A_jm), % Vincolo 2 (Jack Russell) applicato qui
                  pet(zara, A_zara),
                  pet(diego, A_diego),
                  pet(leo, A_leo),
                  pet(cacco, A_cacco),
                  pet(lil, A_lil),
                  pet(camillo, A_camillo) ],
    
    % 2. TESTA: Controlla tutti gli altri vincoli
    
    % Vincolo 1: Diego solo con femmine
    check_diego(Soluzione),
    
    % Vincolo 3: Capacità (da controllare per ogni area)
    check_capacity(1, Soluzione),
    check_capacity(2, Soluzione),
    check_capacity(3, Soluzione).

% --- Helper ---
check_diego(Soluzione) :-
    % 1. Trova l'area in cui si trova Diego
    member(pet(diego, AreaDiego), Soluzione),
    
    % 2. Trova la lista di tutti gli ALTRI coinquilini
    findall(AltroAnimale, 
            (member(pet(AltroAnimale, AreaDiego), Soluzione), AltroAnimale \= diego),
            Coinquilini),
            
    % 3. Controlla che TUTTI i coinquilini siano femmine
    % forall(CondizioneA, CondizioneB) è vero se per ogni 
    % soluzione di A, anche B è vera.
    forall(member(Pet, Coinquilini), female(Pet)).

check_capacity(Area, Soluzione) :-
    % 1. Trova tutti gli animali in quest'area specifica
    findall(Pet, member(pet(Pet, Area), Soluzione), AnimaliInArea),
    
    % 2. Trova i cani e i conigli in quest'area
    findall(Cane, (member(Cane, AnimaliInArea), dog(Cane)), CaniInArea),
    findall(Coniglio, (member(Coniglio, AnimaliInArea), rabbit(Coniglio)), ConigliInArea),
    
    % 3. Ottieni i conteggi
    length(AnimaliInArea, NumAnimali),
    length(CaniInArea, NumCani),
    length(ConigliInArea, NumConigli),
    
    % 4. Applica le regole sulla capacità
    
    % Regola 3a: Massimo 2 cani (SEMPRE)
    NumCani =< 2,
    
    % Regola 3b: Limite animali totali
    ( (NumConigli > 0, NumAnimali =< 3) ;       % Se c'è almeno 1 coniglio, max 3 animali
      (NumConigli =:= 0, NumAnimali =< 2) ).   % Se non ci sono conigli, max 2 animali


% Da terminale per trovare le soluzioni, eseguire la query:
% ?-solve(S).
