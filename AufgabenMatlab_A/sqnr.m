function [sqnr]=sqnr(signal,abtast)
%[v,ab,bit]=wavread('aloha');
%v=lowpass(v, ab,2000);
%signal=sample(signal,abtast,4000);
for i=8:16
   x=linquant_Wert(signal,i);
  a=10*log10((sum((signal).*(signal))/(sum(((x-signal).*(x-signal)))))); 
  plot(i,a,'*')
  hold on;
  xlabel('bit');
  ylabel('SQNR');
end