N=16;
x=ones(1,N);
x(1:4)=0;
xn=0:N-1;
stem(xn,x)
axis([-1 N 0 1.1])
