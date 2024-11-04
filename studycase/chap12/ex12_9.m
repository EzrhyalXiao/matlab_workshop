clc
clear
f = [-5;-3];
A=[4 3
   5 4
   6 3];
b=[11;9;12];
lb = zeros(2,1);
%然后调用linprog函数：
[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb)
