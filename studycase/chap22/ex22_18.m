ww = randn(10,1);
[cov_ww,lags] = xcov(ww,10,'coeff');
subplot(211);
stem(ww)
subplot(212);
stem(lags,c_ww)
