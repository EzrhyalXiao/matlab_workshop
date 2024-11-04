clear all;
F = @(x)1./(x.^3-2*x-5);
Q = quad(F,0,2)
