syms x,y;
f1=sym('sin(x)/(2+sin(x))')
f1 =
	sin(x)/(sin(x) + 2)
taylor(f1)
