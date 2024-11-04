Wp = [60 200]/500; Ws = [50 250]/500;
Rp = 3; Rs = 40;
[n,Wp] = ellipord(Wp,Ws,Rp,Rs)
% Returns n =5 Wp =[0.1200    0.4000]
[b,a] = ellip(n,Rp,Rs,Wp);
freqz(b,a,512,1000);
title('Elliptic Bandpass Filter')
