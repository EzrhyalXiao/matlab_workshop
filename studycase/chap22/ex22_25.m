fs = 5000;                  		%采用频率
t = (0:fs/10)./fs;          	% 1/10s
A = [1 2];                  		% 幅值
f = [150;140];              	% 频率
xn = A*sin(2*pi*f*t) + 0.1*randn(size(t));
subplot(321);plot(t,xn);
Hrect = spectrum.periodogram;
subplot(322);psd(Hrect,xn,'Fs',fs,'NFFT',1024);
Hhamm = spectrum.periodogram('Hamming');
subplot(323);psd(Hhamm,xn,'Fs',fs,'NFFT',1024);
Hs = spectrum.periodogram('rectangular');
subplot(324);psd(Hs,xn,'Fs',fs,'NFFT',1024);
Hs = spectrum.welch('rectangular',150,50);
subplot(325);psd(Hs,xn,'Fs',fs,'NFFT',512);
Hs = spectrum.welch('rectangular',100,75);
subplot(326);psd(Hs,xn,'Fs',fs,'NFFT',512);
