Wp = 40/500; Ws = 150/500;
Rp = 3; Rs = 60;
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs)
[b,a] = cheby2(n,Rs,Ws);
freqz(b,a,512,1000); 
title('Chebyshev Type II Lowpass Filter')
