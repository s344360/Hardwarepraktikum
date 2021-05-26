function b = lowpass(a,fs,grenze)

L=length(a);
%l=-L/2:L/2-1;

if mod(L,2)==0
    l=-L/2:L/2-1; 
else
    l=-(L-1)/2:(L-1)/2;
end

t=L/fs;
f=l/t; 
b=fftshift(fft(a));
b(1:length(b)/2-grenze-1)=0;
b(length(b)/2+grenze+1:length(b))=0;

d=ones(length(f),1);
d(abs(f) > grenze)=0;
b=(d .* b);

b = b(:,1);
dt=1/fs;
t = (-length(b)/2:1:length(b)/2-1);
figure(3)
plot(t,b); xlabel('Frequenz'); ylabel('Häufigkeit');

b=ifft(ifftshift(b));

end