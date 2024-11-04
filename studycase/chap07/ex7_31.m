syms s t;
syms a positive;
f=sym('exp(2*t)+5*dirac(a-t)')
f =
	exp(2*t) + 5*dirac(a - t)
laplace(f,t,s)
