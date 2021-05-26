function A = aufgabeA4(quant)
    
    [A,abtast,bit] = wavread('aloha');
    plot(A,'r-');
    hold on;
    A = linquant(A,quant);
    sound(A,abtast,bit);
    plot(A,'g-');

end