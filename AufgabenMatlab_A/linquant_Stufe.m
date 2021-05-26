function [quantstep]=linquant_Stufe(signal,bits)
step = 2^bits;
quantstep = int2message(round(((signal+1)/2)*(step-1)), bits);
quantstep = quantstep';

end