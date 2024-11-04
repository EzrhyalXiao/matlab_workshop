N=64;
A=4;
f=100;
fai=1;
xn=0:N-1;
x=A*sin(2*pi*f*(xn/N)+fai);
stem(xn,x)
axis([-1, N, (¨CA-0.25),(A+0.25)]
