t=-0.5:0.001:1;
A=3;
f=5;
fai=1;
u=A*sin(2*pi*f*t+fai);
plot(t,u)
axis([-0.5 1 -3.2 3.2])
