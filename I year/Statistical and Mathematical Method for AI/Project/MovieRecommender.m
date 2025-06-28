%% Caricamento del dataset
ratings = readtable(".\data\ratings.csv");
movies = readtable(".\data\movies.csv", detectImportOptions(".\data\movies.csv", 'Delimiter', ',')); % non sceglieva la virgola come delimitatore

% Mi sono servito di questi comandi per capire quando il dataset veniva letto correttamente
%disp(ratings.Properties.VariableNames);
%disp(movies.Properties.VariableNames);
%head(ratings)
%head(movies)

% Se la colonna movieId non è numerica, la converte in numerico
if ~isnumeric(movies.movieId)
    movies.movieId = str2double(movies.movieId);
end

%% Costruzione della matrice utente-film
% Estraggo gli identificatori univoci
userIDs = unique(ratings.userId);
movieIDs = unique(ratings.movieId);

% Inizializza una matrice di dimensione (# utenti x # film) con i valori mancanti impostati a NaN
M = nan(length(userIDs), length(movieIDs));

% per ogni riga della tabella ratings, trova l'indice dell'utente e del film e assegna il rating
for i = 1:height(ratings)
    u = find(userIDs == ratings.userId(i));
    m = find(movieIDs == ratings.movieId(i));
    M(u, m) = ratings.rating(i);
end

% M è una matrice sparsa perché la maggior parte dei valori sono mancanti 
% (gli utenti non votano tutti i film che vedono o comunque non hanno visto tutti i film nel dataset)

% L'SVD non funziona se ci sono valori NaN, quindi bisogna riempire i valori mancanti
% Sostituisco i valori mancanti (NaN) con 0
M(isnan(M)) = 0;

% Dato che la matrice è grande e sparsa posso usare "svds" (calcola una SVD ridotta)
k = 20; % numero di fattori latenti scelti (in questo caso 20 è il numero totale di generi)
[U, S, V] = svds(M, k);

% Per ricostruire la matrice approssimata
%M_approx = U * S * V';

%% Raccomandazione
% Imposto il titolo di input (anche con errori) e il numero di raccomandazioni desiderato
inputTitle = 'Asterix & Obelix';  
numRec = 5;

% Cerca il film esatto nella tabella movies (comparazione case-insensitive)
idx = find(strcmpi(movies.title, inputTitle), 1);
if isempty(idx)
    % Se non viene trovato un match esatto, usa il fuzzy search per trovare il titolo più simile
    suggestedTitle = findClosestMovie(inputTitle, movies);
    if suggestedTitle ~= ""
        fprintf('Siccome hai cercato "%s", potrebbero piacerti:\n', suggestedTitle);
        inputTitle = suggestedTitle;
        idx = find(strcmpi(movies.title, inputTitle), 1);
    else
        error('Nessun titolo simile trovato.');
    end
end

% Recupera il movieId del film selezionato
selectedMovieId = movies.movieId(idx);
% Trova l'indice corrispondente nella lista movieIDs (corrispondente alle colonne della matrice M)
movieColIdx = find(movieIDs == selectedMovieId);
if isempty(movieColIdx)
    error('Il film cercato non è presente nella matrice dei rating.');
end

% Calcola la cosine similarity tra il vettore latente del film target e quelli degli altri film
targetVector = V(movieColIdx, :);
% Calcola la norma (modulo) per ciascun vettore in V (aggiungendo eps per evitare divisioni per zero)
norms = sqrt(sum(V.^2, 2)) + eps;
% Calcola la cosine similarity in modo vettoriale
similarities = (V * targetVector') ./ (norms * norm(targetVector));

% Ordina le similarità in ordine decrescente ed esclude il film target stesso
[~, sortIdx] = sort(similarities, 'descend');
sortIdx(sortIdx == movieColIdx) = [];
topIdx = sortIdx(1:min(numRec, length(sortIdx)));

% Ottiene gli id dei film consigliati
recMovieIds = movieIDs(topIdx);
% Estrae dalla tabella movies i dettagli dei film raccomandati
recommendations = movies(ismember(movies.movieId, recMovieIds), :);

% Visualizza i risultati
disp(recommendations);

%% Fuzzy Search
% Questa funzione cerca il titolo più simile a inputTitle utilizzando editDistance
function bestMatch = findClosestMovie(inputTitle, movies)
    bestMatch = "";
    bestSim = 0;
    threshold = 0.5;  % soglia minima di similarità (50%)
    
    % Converte l'input in minuscolo per confronto case-insensitive
    inputTitleLower = lower(string(inputTitle));
    
    % Itera su ciascun film del dataset
    for i = 1:height(movies)
        currentTitle = movies.title{i};
        % Pulisce il titolo candidato: lo converte in minuscolo e rimuove eventuali parti tra parentesi (es. l'anno)
        currentTitleClean = regexprep(lower(string(currentTitle)), '\s*\(.*\)', '');
        
        % Calcola la distanza di edit tra l'input e il titolo candidato
        d = editDistance(inputTitleLower, currentTitleClean);
        % Determina la lunghezza massima fra i due titoli per normalizzare la distanza
        lenMax = max(strlength(inputTitleLower), strlength(currentTitleClean));
        % Calcola la similarità normalizzata (1 = identico, 0 = completamente diverso)
        sim = 1 - (d / lenMax);
        
        % Se la similarità attuale è migliore di quella migliore finora, aggiorna bestMatch e bestSim
        if sim > bestSim
            bestSim = sim;
            bestMatch = currentTitle;
        end
    end
    
    % Se il miglior punteggio non supera la soglia, non si accetta alcun match
    if bestSim < threshold
        bestMatch = "";
    end
end