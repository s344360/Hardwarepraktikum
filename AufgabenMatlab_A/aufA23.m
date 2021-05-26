% die Dateien laden
% waveread: Read Microsoft WAVE (".wav") sound file.
% Fs: the sample rate in Hertz 
% nbits: the number of bits per sample
 [aloha, aFs, aNbits] = wavread('aloha.wav');
 [run, ruFs, ruNbits] = wavread('run.wav');
 [ring, riFs, riNbits] = wavread('ring.wav');

% lowpass
aloha=lowpass(aloha,aFs,1500); % aloha: lowpass with 1500Hz
run=lowpass(run,ruFs,2000); % run: lowpass with 2000Hz
ring=lowpass(ring,riFs,1500); % ring: lowpass with 1500Hz

% new sampling with 4000Hz
nFs=4000;
aloha=sample(aloha,aFs,nFs); % aloha: new sampling 4000Hz
run=sample(run,ruFs,nFs); % run: new sampling 4000Hz
ring=sample(ring,riFs,nFs); % ring: new sampling 4000Hz

% step quantisation with 4 Bits
bits=4;
aloha=linquant_Stufe(aloha,bits);
run=linquant_Stufe(run,bits);
ring=linquant_Stufe(ring,bits);

% create orthogonal codes for 3 users
% we need walsh matrixs with 4 rows
% first row unusable
H4=walsh(4);
wA=H4(2,:);
wRu=H4(3,:);
wRi=H4(4,:);

% change all signal to equal length
alen=length(aloha);
rulen=length(run);
rilen=length(ring);
maxlen=max(alen,max(rulen,rilen));

aloha(alen+1:maxlen)=0;
run(rulen+1:maxlen)=0;
ring(rilen:maxlen)=0;


% create the signal C
C = spread(aloha,wA)+spread(run,wRu)+spread(ring,wRi);

% decode
adec=despread(C,wA);
rudec=despread(C,wRu);
ridec=despread(C,wRi);

% change length back
adec=adec(1:alen);
rudec=rudec(1:rulen);
ridec=ridec(1:rilen);

% dequantisation
a=relinquant_Stufe(adec,bits);
ru=relinquant_Stufe(rudec,bits);
ri=relinquant_Stufe(ridec,bits);

% sound the signals
sound(a,4000);
sound(ru,4000);
sound(ri,4000);