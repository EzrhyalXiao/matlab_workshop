clc
clear
f = [13;9;10;11;12;8];
A =  [0.6 1.2 1.1 0 0 0
      0 0 0 0.4 1.2 1.0];
b = [600; 900];
Aeq=[1 0 0 1 0 0
     0 1 0 0 1 0
     0 0 1 0 0 1];
beq=[400 600 500];
lb = zeros(6,1);
%然后调用linprog函数：
[x,fval,exitflag,output,lambda] = linprog(f,A,b,Aeq,beq,lb)
