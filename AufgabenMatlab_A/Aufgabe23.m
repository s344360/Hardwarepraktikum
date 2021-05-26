 [alohaSignal, alohaAbtast, alohaBits] = wavread('aloha.wav');
 [runSignal, runAbtast, runbits] = wavread('run.wav');
 [ringSignal, ringAbtast, ringBits] = wavread('ring.wav');

 %alohaSignal=lowpass(alohaSignal,alohaAbtast,1500); 
 %runSignal=lowpass(runSignal,runAbtast,2000);
%5ringSignal=lowpass(ringSignal,ringAbtast,1500);

 alohaSignal = sample(alohaSignal,alohaAbtast,4000);
 runSignal = sample(runSignal,runAbtast,4000);
 ringSignal = sample(ringSignal, ringAbtast,4000);
 
 
 
 alohaSignal = linquant_Stufe(alohaSignal,4);
 runSignal = linquant_Stufe(runSignal,4);
 ringSignal = linquant_Stufe(ringSignal,4);
 
H4=walsh(4);
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
 alohaDekodiert = despread(C,alohaWalsh);
 runDekodiert = despread(C, runWalsh);
 ringDekodiert = despread(C, ringWalsh);
 
 alohaDekodiert=alohaDekodiert(1:alohaLength);
 runDekodiert =runDekodiert(1:runLength);
 ringDekodiert =ringDekodiert(1:ringLength);
 
 alohaAbspielbar = relinquant_Stufe(alohaDekodiert,4);
 ringAbspielbar = relinquant_Stufe(ringDekodiert,4);
 runAbspielbar = relinquant_Stufe(runDekodiert,4);

 sound(alohaAbspielbar);
 %sound(ringAbspielbar);
 %sound(runAbspielbar);
 