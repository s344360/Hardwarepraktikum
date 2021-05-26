function neuabtastung=sample(signal,Fs,nFs)
L=length(signal);  
t=L/Fs;
newL=floor(t*nFs);
x = linspace(1,L,newL);
neuabtastung=interp1(signal,x);

end
