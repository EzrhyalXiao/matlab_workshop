t = -1:0.01:1;
w=0.5;
y= rectpuls(t)
y1= rectpuls (t,w);
subplot(121);
plot(t,y);
axis([-1 1 -0.1 1.1])
subplot(122);
plot(t,y1);
axis([-1 1 -0.1 1.1])
