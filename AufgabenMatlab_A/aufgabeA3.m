function aufgabeA3(x)
    
    [vektor,abtastfrequenz,bit] = wavread('aloha');
    
    neueAbtastfrequenz = floor(abtastfrequenz*x); 
    y = lowpass(vektor, neueAbtastfrequenz, 1500);
    y = sample(vektor, abtastfrequenz, neueAbtastfrequenz);
    %y = lowpass(vektor,neueAbtastfrequenz,1500);
   sound(y);
   plot(y);
   
end

