
n=1000;
x=zeros(1,n);
num=log(3)/log(10);
num=sqrt(2);
num=log(4)/log(10);
%num=exp(1);
x(1)=0.2;
for i=2:n
    x(i)=F(x(i-1),num);
end
%histogram(x)
plot(x,'+')

function[y]=F(x,num)
m=x+num;
y=m-floor(m);
end