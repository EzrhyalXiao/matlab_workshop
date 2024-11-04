fs = 10000;
t = 0:1/fs:2;
x = vco(sawtooth(2*pi*t,0.75),[0.1 0.4]*fs,fs);
subplot(211);
plot(t(1:1500),x(1:1500))
subplot(212);
spectrogram(x,kaiser(256,5),220,512,fs,'yaxis')
