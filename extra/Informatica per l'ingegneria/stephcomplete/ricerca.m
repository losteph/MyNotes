function ricerca(n,v)
k = input("inserisci un numero da cercare all'interno del vettore: ");
i=1;
while i<=n && k ~= v(i)
    i=i+1;
end
if i<=n
    fprintf("elemento trovato \n");
else
    fprintf("elemento non trovato \n");
end
end
