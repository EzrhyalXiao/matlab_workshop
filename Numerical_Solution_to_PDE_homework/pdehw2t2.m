h=0.001;


t=h/2;
x=(h:h:1-h).';
u0=u_0(x);
n=length(x);
A=zeros(n,n);
A(1,1)=1+2*t/h^2;
A(1,2)=-t/h^2;
A(n,n)=1+2*t/h^2;
A(n,n-1)=-t/h^2;
for i=2:n-1
    A(i,i)=1+2*t/h^2;
    A(i,i-1)=-t/h^2;
    A(i,i+1)=-t/h^2;
end
u=A\u0;
for i=2:0.1/t
    u=A\u;
end
u_exa=u_exact(x,0.1,5);
max(abs(u_exa-u))
plot(x,u)
hold on
plot(x,u_exa)
legend('u_{sol}','u_{exact}')
hold off

function[u_next]=implicit(u,t,h)
n=length(u);
A=zeros(n,n);
A(1,1)=1+2*t/h^2;
A(1,2)=-t/h^2;
A(n,n)=1+2*t/h^2;
A(n,n-1)=-t/h^2;
for i=2:n-1
    A(i,i)=1+2*t/h^2;
    A(i,i-1)=-t/h^2;
    A(i,i+1)=-t/h^2;
end
u_next=A\u;
end

function[u]=u_0(x)
u=x;
for i = 1:length(x)
if 0<=x(i)&&x(i)<=1/2
    u(i)=2*x(i);
elseif 1/2<=x(i)&&x(i)<=1
    u(i)=2*(1-x(i));
end
end
end

function[u]=u_exact(x,t,k)
u=0;
for i=1:k
    u=u+8/pi^2/i^2*exp(-i^2*pi^2*t)*sin(i*pi/2).*sin(i*pi*x);
end
end