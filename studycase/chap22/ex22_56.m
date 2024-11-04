t=0:0.01:60
y=sawtooth(t)
y1= sawtooth(t,0.2)
subplot(211)
plot(t,y);
subplot(212)
plot(t,y1);
