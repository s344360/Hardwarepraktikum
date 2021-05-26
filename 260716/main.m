[aloha,fs] = audioread('aloha.wav');
[ring,fs] = audioread('ring.wav');
[run,fs] = audioread('run.wav');

grenze=4000;
neuefs=8025;
bits=4;
wbits=4;

%2.4.1 /////////////////////////////////////////////////////
%WALSHCODE

spreit=walsh(wbits);
display(spreit);
vec1=spreit(2,:);
vec2=spreit(3,:);
vec3=spreit(4,:);


%spraloha=plotten(ring,fs,vec1,bits,grenze,neuefs,wbits);


%2.4.3
%MULTIPLEX - SIMULATION

spraloha=plotten(aloha,fs,vec1,bits,grenze,neuefs,wbits);
sprring=plotten(ring,fs,vec2,bits,grenze,neuefs,wbits);
sprrun=plotten(run,fs,vec3,bits,grenze,neuefs,wbits);

alen=length(spraloha);
rulen=length(sprrun);
rilen=length(sprring);
maxlen=max(alen,max(rulen,rilen));

spraloha(alen+1:maxlen)=0;
sprrun(rulen+1:maxlen)=0;
sprring(rilen:maxlen)=0;

%multiplex-Signal
mplex=spraloha+sprring+sprrun;

audioaloha=despread(mplex,vec1);
audioring=despread(mplex,vec2);
audiorun=despread(mplex,vec3);

audioaloha=relinquant_Stufe(audioaloha,bits);
audioring=relinquant_Stufe(audioring,bits);
audiorun=relinquant_Stufe(audiorun,bits);

sound(audioring,neuefs);

sound(audioring,neuefs);

sound(audiorun,neuefs);



%2.4.4
%VERFÄLSCHUNG


lengeE=length(mplex);
E=[];

for i=1:lengeE
    x=rand;
    if x<0.01  %Fehlerwahrscheindlichkeit bestimmen
        E(i)=-1;
    else
        E(i)=1;
    end
end

mplexf=(mplex .* E);

audioaloha=despread(mplexf,vec1);
audioring=despread(mplexf,vec2);
audiorun=despread(mplexf,vec3);
audioaloha=relinquant_Stufe(audioaloha,bits);
audioring=relinquant_Stufe(audioring,bits);
audiorun=relinquant_Stufe(audiorun,bits);

sound(audioaloha,neuefs);
sound(audioring,neuefs);
sound(audiorun,neuefs);


%2.4.5
%PSEUDO-ZUFALLSFOLGEN

w1=[1, -1, 1, 1, 1, -1, -1];
w2=[1, -1, -1, 1, -1, 1, 1];
w3=[-1, 1, 1, 1, -1, -1, 1];

bitaloha=linquant_Stufe(aloha,bits);
bitring=linquant_Stufe(ring,bits);
bitrun=linquant_Stufe(run,bits);

sbraloha=spread(bitaloha,w1);
sbrring= spread(bitring,w2);
sbrrun= spread(bitrun,w3);

alen=length(sbraloha);
rulen=length(sbrrun);
rilen=length(sbrring);
maxlen=max(alen,max(rulen,rilen));

display(rilen);
display(maxlen);

sbraloha(alen+1:maxlen)=0;
sbrrun(rulen+1:maxlen)=0;
sbrring(rilen:maxlen)=0;

sbrC= sbraloha + sbrrun + 7*sbrring;

audioaloha=despread(sbrC,w1);
audioring=despread(sbrC,w2);
audiorun=despread(sbrC,w3);

audioaloha=relinquant_Stufe(audioaloha,bits);
audioring=relinquant_Stufe(audioring,bits);
audiorun=relinquant_Stufe(audiorun,bits);

sound(audioaloha,neuefs);
sound(audioring,neuefs);
sound(audiorun,neuefs);

display(rilen);
display(maxlen);

sbraloha(alen+1:maxlen)=0;
sbrrun(rulen+1:maxlen)=0;
sbrring(rilen:maxlen)=0;

sbrC= sbraloha + sbrrun + 7*sbrring;

audioaloha=despread(sbrC,w1);
audioring=despread(sbrC,w2);
audiorun=despread(sbrC,w3);

audioaloha=relinquant_Stufe(audioaloha,bits);
audioring=relinquant_Stufe(audioring,bits);
audiorun=relinquant_Stufe(audiorun,bits);

sound(audioaloha,neuefs);
sound(audioring,neuefs);
sound(audiorun,neuefs);