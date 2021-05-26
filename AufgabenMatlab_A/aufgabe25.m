 [alohaSignal, alohaAbtast, alohaBits] = wavread('aloha.wav');
 [runSignal, runAbtast, runbits] = wavread('run.wav');
 [ringSignal, ringAbtast, ringBits] = wavread('ring.wav');
 

 alohaSignal = sample(alohaSignal,alohaAbtast,8000);
 runSignal = sample(runSignal,runAbtast,4000);
 ringSignal = sample(ringSignal, ringAbtast,4000);
 
 alohaSignal = linquant_Stufe(alohaSignal,8);
 runSignal = linquant_Stufe(runSignal,4);
 ringSignal = linquant_Stufe(ringSignal,4);
 
alohaCode=[1, -1, 1, 1, 1, -1, -1];
runCode=[1, -1, -1, 1, -1, 1, 1];
ringCode=[-1, 1, 1, 1, -1, -1, 1];
 
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
 alohaC = spread(alohaSignal,alohaCode);
 runC = spread(runSignal,runCode);
 ringC = spread(ringSignal, ringCode);
 

 C= alohaC + runC + 7*ringC;
 
 alohaDekodiert = despread(C,alohaCode);
 runDekodiert = despread(C, runCode);
 ringDekodiert = despread(C, ringCode);
 
 alohaDekodiert=alohaDekodiert(1:alohaLength);
 runDekodiert =runDekodiert(1:runLength);
 ringDekodiert =ringDekodiert(1:ringLength);
 
 alohaAbspielbar = relinquant_Stufe(alohaDekodiert,8);
 ringAbspielbar = relinquant_Stufe(ringDekodiert,4);
 runAbspielbar = relinquant_Stufe(runDekodiert,4);

 sound(alohaAbspielbar);
 %sound(ringAbspielbar);
 %sound(runAbspielbar);
 