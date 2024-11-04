function f = opt1(x)
f = -(3-2*x).^2 * x;
x = fminbnd(@opt1,0,1.5)