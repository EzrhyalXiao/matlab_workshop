N=50;
	x=zeros(1,N);
	x(1)=1;
	xn=0:N-1;
	stem(xn,x)
	axis([-1 N+1 0 1.1])
