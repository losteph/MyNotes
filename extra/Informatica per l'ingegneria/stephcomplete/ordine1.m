function [v] = ordine1(n,v)
%bubblesort
i=2;
while i<=n
    j=n;
    while j>=i
        if v(j-1) > v(j)
            temp=v(j);
            v(j)=v(j-1);
            v(j-1)=temp;
        end
        j=j-1;
    end
    i=i+1;
end
end