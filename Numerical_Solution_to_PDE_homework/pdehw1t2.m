n=64;
a=0;
b=2*pi;
dt=(b-a)/n;
h=a:dt:b;
theta1=0.1*pi;
theta2=-0.1*pi;
K=1;
u0=zeros(1,n+1);

tol=1.e-10;
error=1;
u=u0';
k=0;%迭代次数
while error>tol %牛顿迭代
delta_u=-dF(u,n+1,dt,K)\F(u,n+1,theta1,theta2,dt,K);
u=u+delta_u;
error=max(abs(delta_u));
k=k+1;
end
%plot(h,u);
fprintf(string(k));


A=zeros(n+1,n+1);%求解非线性微分方程的线性化形式
A(1,1)=1;
A(n+1,n+1)=1;
for i=2:1:n
A(i,i-1)=1/dt^2;
A(i,i)=-2/dt^2+K;
A(i,i+1)=1/dt^2;
end
b=zeros(n+1,1);
b(1)=theta1;
b(n+1)=theta2;
u2=A\b;
plot(h,u2)
%plot(h,u2-u)
%fprintf(string(max(abs(u2-u))))

function [y] = F(u,n,theta1,theta2,h,K)%定义非线性微分方程导出的非线性差分方程组
y=zeros(1,n);
y(1)=u(1)-theta1;
y(n)=u(n)-theta2;
for i=2:1:(n-1)
	y(i)=(u(i+1)+u(i-1)-2*u(i))/h^2+K*sin(u(i));
end
y=y';
end
	
function [y] = dF(u,n,h,K)%定义非线性差分方程组的Jacobi矩阵
y=zeros(n,n);
y(1,1)=1;
y(n,n)=1;
for i=2:1:(n-1)
	y(i,i-1)=1/(h^2);
	y(i,i)=-2/(h^2)+K*cos(u(i));
	y(i,i+1)=1/(h^2);
end
end

