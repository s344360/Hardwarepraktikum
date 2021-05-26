function wh = walsh(n)

if(n==1)
    wh=1;
else
    half_n = walsh(n/2);    
    wh=[half_n half_n; half_n (-1)*half_n];  
    
end