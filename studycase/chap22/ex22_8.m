N=32;
A=3;
a=0.7;
w=314;
xn=0:N-1;
x=A*exp((a+j*w)*xn);
stem(xn,x)
