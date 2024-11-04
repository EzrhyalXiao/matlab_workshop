Wp = [60 200]/500; Ws = [50 250]/500;
Rp = 3; Rs = 40;
[n,Wp] = cheb1ord(Wp,Ws,Rp,Rs)
[b,a] = cheby1(n,Rp,Wp);
freqz(b,a,512,1000);
title('Chebyshev Type I Bandpass Filter')
