Wp = 40/500; Ws = 150/500;
Rp = 3; Rs = 60;
[n,Wp] = ellipord(Wp,Ws,Rp,Rs)
[b,a] = ellip(n,Rp,Rs,Wp);
freqz(b,a,512,1000);
title('Elliptic Lowpass Filter')
