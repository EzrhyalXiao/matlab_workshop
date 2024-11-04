load mtlb
Hwelch = spectrum.welch('hamming',256,50);
subplot(221);psd(Hwelch,mtlb,'Fs',Fs,'NFFT',1024)
Hyulear = spectrum.yulear(14);
subplot(222);psd(Hyulear,mtlb,'Fs',Fs,'NFFT',1024)
Hburg = spectrum.burg(14); 
subplot(223);psd(Hburg,mtlb,'Fs',Fs,'NFFT',1024)
Hcov = spectrum.cov(14); 
subplot(224);psd(Hcov,mtlb,'Fs',Fs,'NFFT',1024)
