N=32;
x_rand=rand(1,N);
x_randn=randn(1,N);
xn=0:N-1;
subplot(211);
stem(xn,x_rand)
subplot(212);
stem(xn,x_randn)
