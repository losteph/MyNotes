function [v] = ordine3(n,v)
i=1;
while i<n
    k=i;
    j=i+1;

    while j<=n
        if v(k)>v(j)
            k=j;
        end
        j=j+1;
    end

    if i ~= k
        temp=v(i);
        v(i)=v(k);
        v(k)=temp;
    end
    i=i+1;
end