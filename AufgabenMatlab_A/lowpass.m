function [tiefpass]=lowpass(signalvektor,abtastefrequenz,grenzfrequenz)

L=length(signalvektor);
if mod(L,2)==0
    l=-L/2:L/2-1; 
else
    l=-(L-1)/2:(L-1)/2;
end
T=L/abtastefrequenz;
freq=l/T; 
signal=(fftshift(fft(signalvektor)));
    
tiefpass = ones(length(freq),1);
tiefpass(abs(freq) > grenzfrequenz) = 0;
tiefpass = ifft(ifftshift(tiefpass .* signal));
end
