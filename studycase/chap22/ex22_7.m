clear all;
N=32;
A=5;
a=0.6;
xn=0:N-1;
x=A*a.^xn;
stem(xn,x)
