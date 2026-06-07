function [v] = ordine2(n,v)
%per inserimento
j=2;
flag = true;
while flag == true
    i=j-1;
    k=v(j);
    while i>0 && v(i)>k
        v(i+1)=v(i);
        i=i-1;
    end
    v(i+1) = k;
    j=j+1;

    if j>n
        flag=false;
    end
end