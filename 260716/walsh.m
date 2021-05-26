function spreit= walsh(n)

if (n==1)
    spreit=1;   
else    
    div = walsh(n/2);
    spreit=[div div;div (-1)*div];
end