t = 0:0.001:2; 
y = chirp(t,0,1,150);  
y1 = chirp(t,100,1,200,'quadratic');
subplot(121)
spectrogram(y,256,250,256,1E3,'yaxis')
colorbar;
subplot(122)
spectrogram(y1,128,120,128,1E3,'yaxis')
colorbar;
