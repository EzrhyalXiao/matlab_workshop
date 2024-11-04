syms x;
f=sym('a*Dx+b*x=0')
f =
	Dx*a + b*x == 0
dsolve(f)
