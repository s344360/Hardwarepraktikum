


aloha=wavread('aloha');
subplot(3,2,1);
plot(aloha);
title = ('AufgabeA1');
xlabel('Zeit in Abtastproben');
ylabel('Amplitudte normiert');
alohaFFT =real(fftshift(fft((aloha))));

ring=wavread('ring');
subplot(3,2,3);
plot(ring);
title = ('AufgabeA1');
xlabel('Zeit in Abtastproben');
ylabel('Amplitudte normiert');
alohaFFT =real(fftshift(fft((ring))));


