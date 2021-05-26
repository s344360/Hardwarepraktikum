function sqnr=sqnr(sig)

for i=(8:16)    %Aufgabesteullung 8-16 Bit
    x=linquant_Wert(sig,i);
    a=10*log10((sum((sig).*(sig))/(sum(((x-sig).*(x-sig)))))); 
    figure(7)
    plot(i,a,'.');
    hold on;
    xlabel('Bits');
    ylabel('SQNR');
end
end