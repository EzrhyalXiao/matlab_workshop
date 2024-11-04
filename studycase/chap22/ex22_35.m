Wp = 40/500; Ws = 150/500;
Rp = 3; Rs = 60;
[n,Wp] = cheb1ord(Wp,Ws,Rp,Rs)
[b,a] = cheby1(n,Rp,Wp);
freqz(b,a,512,1000); 
title('Chebyshev Type I Lowpass Filter')
