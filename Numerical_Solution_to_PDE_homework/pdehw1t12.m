n=256;
a=2;
b=-3; 
c=0;
dx=1/n;
h=0:dx:1;
U=u(h);
%plot(h,U);

A=zeros(n+2,n+2);
A(1,1)=1;
for i=2:1:n+1
xi=(i-1)*dx;
A(i,i+1)=beta(xi)/dx^2+betadot(xi)/(2*dx);
A(i,i)=-gamma(xi)-2*beta(xi)/dx^2;
A(i,i-1)=beta(xi)/dx^2-betadot(xi)/(2*dx);
end
A(n+2,n+2)=0.5*b/dx;
A(n+2,n+1)=a;
A(n+2,n)=-0.5*b/dx;

F=f(h);
F(1)=1;
F(n+2)=c;
F=F';
X=A\F;
X=X(1:n+1);

%plot(h,X-U');
%plot(h,X)
max(max(abs(X-U')))

function [y] = gamma(x)
y=x;
end
function [y] = beta(x)
y=1+x.^2;
end
function [y] = f(x)
y=exp(-x).*(x.^4-9*x.^3+18*x.^2-13*x+7);
end
function [y] = u(x)
y=exp(-x).*(x-1).^2;
end

function[y]=betadot(x)
	y=2*x;
end