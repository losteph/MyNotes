# Prolog Tutorial

## Basics
Per avviare SWI-Prolog da terminale, usando VScode con relativa estensione, 
bisogna assicurarsi di essere nella cartella in cui è situato il programma "name.pl" ("name": nome del programma da runnare), 
e digitare su terminale bash:
swipl

Dopo di che bisogna caricare il programma, per farlo abbiamo due metodi:
?- consult("name.pl").
?- \[name\].

Poi è possibile eseguire tutte le query necessarie a seconda del programma.
Se abbiamo più soluzioni, dopo aver ottenuta la prima basta digitare ; per ottenere le altre (1 alla volta).

Quando è necessario uscire dall'ambiente di programmazione SWI bisogna digitare:
?- halt.

per attivare il debbugger:
?- trace.

Per disattivarlo:
?- notrace.

---

## Other
Le constanti in prolog vengono scritte in minuscolo mentre le variabili scritte con lettere maiuscole (o almento l'iniziale grande).

quando vediamo il simbolo :- ci stiamo riferendo ad una regola, ad esempio:
a :- b vuol dire che "$b \implies a$"

quando vediamo il simbolo , dopo un predicato si riferisce all' AND logico
l'or logico si può effettuare mettendo dopo i predicati il . e scriverli quindi come predicati a parte oppure usare il ; tra due predicati

write("something") serve per scrivere qualcosa sul terminale
nl serve per andare a capo

---

scrivere \\+ è uguale a verificare se qualcosa è diverso
questo invece per vedere se l'uguaglianza è verificata =:=
invece se non è verificata =\=

mod(\_,\_) da il modulo degli argomenti

con is assegni un valore ad una variabile

random(0,10,X) genera un valore casuale tra 0 e 10

succ(2,X) il successore (otteniamo 3)

abs(X) il valore assoluto

rount() arrotondamento
truncate() toglie la virgola
floor() arrotondamento per difetto
cealing() arrotondamento per eccesso

la divisione è //


read(X) permettete di inserire output da tastera

il cut è ! serve a porre fine al backtracking


---

length() ti da la lunghezza di qualcosa che metti come imput (solitamente una lista)


\[H|T\] = \[a, b, c\] restituisce come output
H = a 
T = \[b, c\]

member serve a verificare se un elemento è presente in una lista

member(a, List)

reverse(List) ti da l'inverso di una lista

append unisce due liste o un elemento ad una lista




