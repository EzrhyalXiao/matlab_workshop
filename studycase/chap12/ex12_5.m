f = [-0.18;-0.1;-0.09;-0.12];
A =  [1 -1 -1 -1
      0 -1 -1 1];
b = [0; 0];
Aeq=[1 1 1 1];
beq=[1];
lb = zeros(4,1);
%然后调用linprog函数：
[x,fval,exitflag,output,lambda] = linprog(f,A,b,Aeq,beq,lb)
