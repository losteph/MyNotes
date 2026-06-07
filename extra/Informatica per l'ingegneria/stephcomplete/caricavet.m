function [v] = caricavet(n)
i = 1;
v=zeros(1,n);
while i<=n
    v(i)=input("inserisci elemento vettore: ");
    i=i+1;
end