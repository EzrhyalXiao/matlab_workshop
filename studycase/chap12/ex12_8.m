clc
clear
f = [40;36];
A=[1 0
   0 1
   -5 -3];
b=[7;8;-45];
lb = zeros(2,1);
%然后调用linprog函数：
[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb)
