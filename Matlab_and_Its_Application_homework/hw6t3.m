syms t
n =6;
F1 = laguerreL(n, t);
F2=laguerreL(n+1, t);
x=roots(sym2poly(F1));
w=x./((n+1)^2*(eval(subs(F2,x))).^2);

f= 1/(1+t^4);
result=w.'*eval(subs(f,x));


eval(int(exp(-t)/(1+t^4),0,inf))