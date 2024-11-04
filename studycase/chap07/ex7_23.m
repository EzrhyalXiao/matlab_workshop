syms x y;
f=sym('x+x^-1')
f =
	x + 1/x
g=sym('sin(x)')
g =
	sin(x)
h=sym('1+y^2')
h =
	y^2 + 1
compose(f,g)
