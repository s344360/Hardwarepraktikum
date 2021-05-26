function despr = despread(x,sc)
 lang_sc  =length(sc);
 lang_x =length(x);
 division=lang_x/lang_sc;
 antwort=0;
 decode=[];
 a=1;
 zaehler=1;
 for i = 1:division
     mul=i*lang_sc;
     for y= a : mul
        antwort=antwort+x(y)*sc(zaehler);
        zaehler=zaehler+1;
     end
     zaehler=1;
     a=mul+1;
     decode=[decode sign(antwort)];
     antwort=0;
 end
 despr = decode;
end