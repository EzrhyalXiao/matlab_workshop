N=32;
k=4;
B=3;
t0=1;
x=[zeros(1,k) ones(1,N-k)];
for i=1:N
   x(i)=B*x(i)*(i-k);
end
xn=0:N-1;
stem(xn,x)
axis([-1 32 0 90])
