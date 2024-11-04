function F = ex4_19(n)
A = 1; w = 2; phi = pi/2;
signal = createsig(A,w,phi);
F = signal.^n;
%---------subfunction---------
function signal = createsig(A,w,phi)
x = 0: pi/100 : pi*2;
signal = A * sin(w*x+phi);
