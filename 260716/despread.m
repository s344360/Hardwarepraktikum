function despr=despread(cvec,sprc)
l_cvec=length(cvec);
l_sprc=length(sprc);
div=l_cvec/l_sprc;
dec=[];
count=1;
v=1;
res=0;
for i=1:div
    mul=i*l_sprc;
    for j=v : mul
        res = res+cvec(j)*sprc(count);
        count=count+1;
    end
    count=1;
    v=mul+1;
    dec=[dec sign(res)];
    res=0;
    
end
despr=dec;
end