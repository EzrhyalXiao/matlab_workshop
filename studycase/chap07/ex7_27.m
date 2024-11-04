		syms x,y;
		f1=sym('x+x^-1')
		int(f1)
		f2=sym('x*y+(x*y)^-1')
		int(f2,y)
		int(f1,1,2)
		int(f2,y,1,2)
