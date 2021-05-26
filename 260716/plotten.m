function spr=plotten(a,fs,vec,bits,grenze,neuefs,wbits)

%sound(real(e),neuefs);

%1.3.1 //////////////////////////////////////////////////////
%ZEITBEREICH
dt=1/10000;
t = dt:dt:length(a)*dt;

figure(1)
plot(t,a); xlabel('Sekunden'); ylabel('Amplitude');

%FOURIER

b=fftshift(fft(a));
b = b(:,1);
t2 = (-length(b)/2:length(b)/2-1);

figure(2)
plot(t2,real(b)); xlabel('Frequenz'); ylabel('Häufigkeit');

%1.3.2/////////////////////////////////////////////////////
%TIEFPASS

d=lowpass(a,fs,grenze);

%d=d(:,1);
t3 = dt:dt:(length(d)*dt); %liefert Sekunden als Einheiten

sound(real(d),fs);

figure(4)
plot(t3,d); xlabel('Sekunden'); ylabel('Amplitude');


%1.3.3 /////////////////////////////////////////////////////
%SAMPLE

e=sample(d,fs,neuefs);

dt2=fs/neuefs;
t4 = 1:dt2:(length(e)*dt2);

figure(5)
plot(t4,e); xlabel('Sekunden'); ylabel('Amplitude');

audiowrite('neuefs.wav',e,neuefs)

display(fs);
display(neuefs);

%1.3.4 /////////////////////////////////////////////////////
%LINQUANT - WERTE

g=linquant_Wert(e,bits);
t4=dt2:dt2:length(e)*dt2;

figure(6)
plot(t4,g); xlabel('Milisekunden'); ylabel('Amplitude');

%1.3.5 /////////////////////////////////////////////////////
%SQNR

sqnr(e);

%1.3.6 /////////////////////////////////////////////////////
%LINQUANT-STUFEN

bin=linquant_Stufe(g,bits);
%display(bin);

dec=relinquant_Stufe(bin,bits);
%display(dec);

figure(8)
plot(t4,dec); xlabel('Milisekunden'); ylabel('Amplitude');

%2.4.2 /////////////////////////////////////////////////////
%SPREAD

%vec = gewählte Walshcode
spr=spread(bin,vec);   %liefert gespreitzten Kode

%display(spr);
%display(length(spr));
%display(length(bin));

des=despread(spr,vec);

