t = -1:0.01:1;
w=0.5;
s=1;
y=tripuls(t);
y1=tripuls(t,w);
y2=tripuls(t,w,s);
subplot(131);
plot(t,y);
subplot(132);
plot(t,y1);
subplot(133);
plot(t,y2);
