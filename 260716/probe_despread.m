%[a,fs] = audioread('/HOME/s343001/Studium/HWP/Material/Aufgabe_1_und_2/aloha.wav');


vec1=[1 1 -1 1];
vec2=[-1 1 1 -1];

sprc=walsh(4);
sprc1=sprc(2,:);
sprc2=sprc(3,:);

cvec1=spread(vec1,sprc1);
cvec2=spread(vec2,sprc2);

display(cvec1);
display(cvec2);

cvec=cvec1+cvec2;
display(cvec);

audio=despread(cvec,sprc2);
display(audio);