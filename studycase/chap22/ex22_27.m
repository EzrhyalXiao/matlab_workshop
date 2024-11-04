T = 0:0.001:2;
X = chirp(T,0,1,150);
subplot(121);plot(T,X)
xlabel('Time (Seconds)'); ylabel('Amp');
subplot(122); [S,F,T,P] = spectrogram(X,256,250,256,1E3);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
xlabel('Time (Seconds)'); ylabel('Hz');
view(0,90);
colorbar
