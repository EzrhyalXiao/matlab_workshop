t=0:0.01:60
y= square (t)
y1= square (t,10)
subplot(211)
plot(t,y);
axis([-0 60 -1.1 1.1])
subplot(212)
plot(t,y1);
axis([-0 60 -1.1 1.1])
