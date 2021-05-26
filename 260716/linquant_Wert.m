function g=linquant_Wert(signal,bits)

g=round(((signal+1)/2)*(2^bits-1));
g=g*2/(2^bits-1)-1;

end