% --- FATTI ---
% prodotto(ID, Categoria, QuantitaDisponibile, PrezzoUnitario)
prodotto(p100, hardware, 50, 15).
prodotto(p101, hardware, 20, 70).
prodotto(p102, software, 5, 200).
prodotto(p103, consumabili, 300, 2).
prodotto(p104, hardware, 15, 45).
prodotto(p105, consumabili, 150, 5).
prodotto(p106, software, 10, 80).

in_scorta(ID) :-
    prodotto(ID, _, Q, _),
    Q > 0.

valore_prodotto(ID, Valore) :-
    prodotto(ID, _, Q, P),
    Valore is Q*P.

cerca_per_categoria(Categoria, ListaID) :-
    findall(ID, prodotto(ID, Categoria, _, _), ListaID).
    


valore_totale_categoria(Categoria, ValoreTotale) :-
    % 1. Troviamo prima la lista di tutti i singoli valori per quella categoria.
    % Usiamo una query complessa come Goal:
    findall(ValoreSingolo,
            (   prodotto(ID, Categoria, _, _),    % Trova un prodotto della categoria
                valore_prodotto(ID, ValoreSingolo) % Calcolane il valore
            ),
            ListaValori), % Metti i valori in [750, 1400, 675] per 'hardware'
    
    % 2. Sommiamo la lista
    sum_list(ListaValori, ValoreTotale).

% --- Predicato Helper per sommare una lista ---
% (Questo è un predicato ricorsivo standard)

% Caso Base: La somma di una lista vuota è 0.
sum_list([], 0).

% Passo Ricorsivo: La somma di [H|T] è (H + somma di T).
sum_list([H|T], SommaTotale) :-
    sum_list(T, SommaCoda),          % Calcola la somma del resto della lista
    SommaTotale is H + SommaCoda.
