errs=zeros(6,1);
for i=3:8
    n=2^i;
    errs(i-2)=fem1d(n);
end

function[error]=fem1d(n)
%n=60;
a=0;
b=2*pi;
dx=(b-a)/n;
x=a:dx:b;
f=@(x) -cos(x)+(2*x+1).*sin(x);
p=@(x) 1+x;
q=@(x) x;
A=zeros(n-1,n-1);%stiff
A(1,1)=integral(p,a,a+2*dx)/dx^2;
A(1,2)=-integral(p,a+dx,a+2*dx)/dx^2;
A(n-1,n-1)=integral(p,x(n-1),x(n+1))/dx^2;
A(n-1,n-2)=-integral(p,x(n-1),x(n))/dx^2;
for i=2:n-2
    A(i,i-1)=-integral(p,x(i),x(i+1))/dx^2;
    A(i,i)=integral(p,x(i),x(i+2))/dx^2;
    A(i,i+1)=-integral(p,x(i+1),x(i+2))/dx^2;
end

B=zeros(n-1,n-1);%stiff
for i=1:n-1
    phi=@(y) abs(y-x(i+1))/dx;
    b1=@(y) phi(y).^2.*q(y);
    B(i,i)=integral(b1,x(i),x(i+2));
    if i>1
        b2=@(y) phi(y).*phi(y+dx).*q(y);
        B(i,i-1)=integral(b2,x(i),x(i+1));
    end
    if i<n-1
        b3=@(y) phi(y).*phi(y-dx).*q(y);
        B(i,i+1)=integral(b3,x(i+1),x(i+2));
    end
end

F=zeros(n-1,1);
for i=1:n-1
    fv=@(y) f(y).*abs(y-x(i+1))/dx;
    F(i)=integral(fv,x(i),x(i+2));
end

xishu=[0;(A+B)\F;0];
%plot(x,xishu)
hold on
%plot(x,sin(x))
error=max(abs(sin(x).'-xishu));
end

function[f]=fem(y,x,xishu)
n=ceil(y-x(1)/(x(2)-x(1)));
f=xishu(n+1)+(y-xishu(n+1))*(xishu(n+2)-xishu(n+2))/(x(2)-x(1));
end
