function linquant=linquant_Wert(signal,bits)
step=2^bits;
linquant=round(((signal+1)/2)*(step-1));  
linquant=linquant*2/(step-1)-1;
end