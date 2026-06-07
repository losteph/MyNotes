function massimo(n,v)
i=1;
m=max(v);
while i<=n && m ~= v(i)
    i=i+1;
end
fprintf("il massimo è: %d",m);
fprintf(" e si trova in posizione: %d",i);
end