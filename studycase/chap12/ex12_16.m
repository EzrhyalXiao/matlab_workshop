function f=ex12_16(x)
f(1)=3*x(1)+ 2*x(2);
        f(2)=-x(1)- x(2);
        f(3)=-x(1);
%给定目标，权重按目标比例确定，给出初值：
goal=[300 -200 40];
weight=[300 -200 40];
x0=[55 55];
%给出约束条件的系数：
  A=[2 1;-1 -1;-1 0];
  b=[300 -200 -40];
 [x,fval,attainfactor,exitflag]=fgoalattain(@ex10_16,x0,goal,…
weiht,A,b,[],[],lb,[],[])
