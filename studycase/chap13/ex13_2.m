load freqbrk
s=freqbrk;
ls=length(s);
[C,L]=wavedec(s,4,'db5');
A4=wrcoef('a',C,L,'db5',4);
D4=wrcoef('d',C,L,'db5',1);
subplot(3,1,1);plot(abs(s),'k');
subplot(3,1,2);plot(abs(A4),'k');
subplot(3,1,3);plot(abs(D4),'k');
