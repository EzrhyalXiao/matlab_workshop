Wp = [60 200]/500; Ws = [50 250]/500;
Rp = 3; Rs = 40;
[n,Ws] = cheb2ord(Wp,Ws,Rp,Rs)
[b,a] = cheby2(n,Rs,Ws);
freqz(b,a,512,1000)
title('n=7 Chebyshev Type II Bandpass Filter')
