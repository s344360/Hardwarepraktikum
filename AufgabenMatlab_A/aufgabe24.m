 [alohaSignal, alohaAbtast, alohaBits] = wavread('aloha.wav');
 [runSignal, runAbtast, runbits] = wavread('run.wav');
 [ringSignal, ringAbtast, ringBits] = wavread('ring.wav');
 

 %alohaSignal = sample(alohaSignal,alohaAbtast,8000);
 %runSignal = sample(runSignal,runAbtast,4000);
 %ringSignal = sample(ringSignal, ringAbtast,4000);
 
 alohaSignal = linquant_Stufe(alohaSignal,8);
 runSignal = linquant_Stufe(runSignal,4);
 ringSignal = linquant_Stufe(ringSignal,4);
 
H4=walsh(64);
alohaWalsh=H4(2,:);
runWalsh=H4(3,:);
ringWalsh=H4(4,:);
 
 alohaLength = length(alohaSignal);
 runLength = length(runSignal);
 ringLength = length(ringSignal);
 
 if (alohaLength > runLength) && (alohaLength > ringLength)
       runSignal(runLength+1:alohaLength)=0;
       ringSignal(ringLength+1:alohaLength)=0;
 end
 if (runLength > alohaLength) && (runLength > ringLength)
     alohaSignal(alohaLength+1:runLength)=0;
     ringSignal(ringLength+1:ringLength)=0;
 end
 if (ringLength > alohaLength) && (ringLength > runLength)
     alohaSignal(alohaLength+1:ringLength)=0;
     runSignal(runLength+1:ringLength)=0;
 end
 alohaC = spread(alohaSignal,alohaWalsh);
 runC = spread(runSignal,runWalsh);
 ringC = spread(ringSignal, ringWalsh);
 

 C= alohaC + runC + ringC;
 %ab hier Aufgabe 2.4
 p1 = 0.1;
 p2 = 0.01;
 
 
 E = ones(1,length(C));
 zwischenergebnis = length(C)* p2;
 step = round(length(C)/zwischenergebnis);
 for i = 1:length(E)
    if mod(i,step)==0
        E(i) = -1;
    end
 end
 Cneu = E .* C;
%Ende Aufgabe 2.4
 alohaDekodiert = despread(Cneu,alohaWalsh);
 runDekodiert = despread(Cneu, runWalsh);
 ringDekodiert = despread(Cneu, ringWalsh);
 
 alohaDekodiert=alohaDekodiert(1:alohaLength);
 runDekodiert =runDekodiert(1:runLength);
 ringDekodiert =ringDekodiert(1:ringLength);
 
 alohaAbspielbar = relinquant_Stufe(alohaDekodiert,8);
 ringAbspielbar = relinquant_Stufe(ringDekodiert,4);
 runAbspielbar = relinquant_Stufe(runDekodiert,4);

 sound(alohaAbspielbar);
 %sound(ringAbspielbar);
 %sound(runAbspielbar);
 