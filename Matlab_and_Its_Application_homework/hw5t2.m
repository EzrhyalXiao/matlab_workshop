m1=1;
m2=2;
l=2;
g=9.8;
M=m2/(m1+m2);
x_0=[pi/4;1;0;0];
%x1~4 分别表示θ θ' x x'
f=@(t,x) [x(2);-(M*cos(x(1))*sin(x(1))*x(2)^2+g/l*sin(x(1)))/(1-M*cos(x(1))^2);x(4);(M*g*sin(x(1))*cos(x(1))+M*l*sin(x(1))*x(2)^2)/(1-M*cos(x(1))^2)];
[time,x_sol]=ode45(f,[0,5],x_0);

for i=1:3:length(time)
x1=x_sol(i,3);
x2=x_sol(i,3)+l*sin(x_sol(i,1));
y2=-l*cos(x_sol(i,1));
scatter(x1,0)
hold on
scatter(x2,y2)
hold on
plot(-1:1:7,zeros(9,1));
hold on
plot(linspace(x1,x2,10),linspace(0,y2,10));
axis([-1 7 -4 1]);
title(sprintf('t = %.2f',time(i))); 
pause(0.1); 
hold off
end