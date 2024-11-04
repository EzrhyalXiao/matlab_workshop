syms x;
f=sym('a*x+b*x^-1+c')
f =
	c + a*x + b/x
solve(f)
