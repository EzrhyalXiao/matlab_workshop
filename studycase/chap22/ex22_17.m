ww = randn(10,1);
[c_ww,lags] = xcorr(ww,10,'coeff');
subplot(211);
stem(ww)
subplot(212);
stem(lags,c_ww)
