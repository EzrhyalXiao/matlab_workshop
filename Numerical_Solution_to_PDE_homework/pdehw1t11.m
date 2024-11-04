n=80;
a=2;
b=-3; 
c=0;
dx=1/n;
h=0:dx:1;
U=u(h);
plot(h,U);
hold on;

A=zeros(n+2,n+2);
A(1,1)=1;
for i=2:1:n+1
xi=(i-1)*dx;
A(i,i+1)=beta(xi+0.5*dx)/dx^2;
A(i,i)=-beta(xi+0.5*dx)/dx^2-beta(xi-0.5*dx)/dx^2-gamma(xi);
A(i,i-1)=beta(xi-0.5*dx)/dx^2;
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

plot(h,X)
error=max(max(abs(X-U')));
legend(' exact solution','computed solution', 'Location','Northeast');
fprintf('errors for grid n = %d: %f',n,error)

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