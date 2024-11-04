function f=ex12_14(x)
        f(1)=3*x(1)+6*x(2);
        f(2)=2*x(1)+x(2);
%给定目标，权重按目标比例确定，给出初值：
goal=[16 14];
weight=[16 14];
x0=[2 5];
%给出约束条件的系数：
A=[1 0;0 1;-1 -1];
b=[5 6 -7];
lb=zeros(2,1);
 [x,fval,attainfactor,exitflag]= ...
fgoalattain(@ex10_14,x0,goal,weight,A,b,[],[],lb,[])
