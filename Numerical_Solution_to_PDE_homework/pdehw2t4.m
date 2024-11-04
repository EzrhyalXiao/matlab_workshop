h=0.01;
tau=0.002;
t=1;
x=(0:h:1).';
u0=x.^2;
a=3;
n=length(x);
A=zeros(n-2,n);
for i=1:n-2
    A(i,i+1)=1-a^2*tau^2/h^2;
    A(i,i)=a*tau/(2*h)+a^2*tau^2/(2*h^2);
    A(i,i+2)=-a*tau/(2*h)+a^2*tau^2/(2*h^2);
end
%u2=2*u0(n-1)-u0(n-2);
%u1=2*u0(2)-u0(3);
%u1=a^2*tau^2;
%u2=(1-a*tau)^2;
u1=(1+3*a*tau/(2*h)+a^2*tau^2/(2*h^2))*u0(1)+(-2*a*tau/h-a^2*tau^2/h^2)*u0(2)+(a*tau/(2*h)+a^2*tau^2/(2*h^2))*u0(3);
u2=(1-3*a*tau/(2*h)+a^2*tau^2/(2*h^2))*u0(n)+(2*a*tau/h-a^2*tau^2/h^2)*u0(n-1)+(-a*tau/(2*h)+a^2*tau^2/(2*h^2))*u0(n-2);
u=A*u0;
u=[u1 ;u ;u2];
%u=[2*u(1)-u(2); u; 2*u(n-2)-u(n-3)];
for i=2:t/tau
    %u2=2*u(n-1)-u(n-2);
    %u1=2*u(2)-u(3);
    %u1=a^2*i^2*tau^2;
    %u2=(1-a*i*tau)^2;
    u1=(1+3*a*tau/(2*h)+a^2*tau^2/(2*h^2))*u(1)+(-2*a*tau/h-a^2*tau^2/h^2)*u(2)+(a*tau/(2*h)+a^2*tau^2/(2*h^2))*u(3);
    u2=(1-3*a*tau/(2*h)+a^2*tau^2/(2*h^2))*u(n)+(2*a*tau/h-a^2*tau^2/h^2)*u(n-1)+(-a*tau/(2*h)+a^2*tau^2/(2*h^2))*u(n-2);
    u=A*u;
    u=[u1; u; u2];
    %u=[2*u(1)-u(2); u; 2*u(n-2)-u(n-3)];
end
u_exa=(x-3*t).^2;
max(abs(u_exa-u))
plot(x,u)
hold on
plot(x,u_exa)
legend('u_{sol}','u_{exact}')
hold off