function [m,n,p]=myfuntion(A)
m=sum(sum(A>2));
n=sum(sum(A<2));
p=sum(sum(A==2));
disp('大于2的个数')
disp(m)
disp('小于2的个数')
disp(n)
disp('等于2的个数')
disp(p)
