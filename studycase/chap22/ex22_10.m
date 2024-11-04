N=32;
w=100;
k=5;
x1=zeros(1,k);
xn=0:N-1;
x2=sin(100*xn);
subplot(211);
stem(xn,x2)
x=[x1 x2];
axis([-1 N -1.1 1.1])
N=N+k;
xn=0:N-1;
subplot(212);
stem(xn,x)
axis([-1 N -1.1 1.1])
