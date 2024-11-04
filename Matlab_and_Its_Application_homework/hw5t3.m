clear ;close;
sinit=bvpinit(0:4,[1,0,0]);
%y1~3 分别表示y y'y"
odefun=@(x,y)[y(2);y(3);x-10*x*(y(1))^2-x^2*y(2)-2*y(3)];
bcfun=@(ya,yb)[ya(1);ya(2)-1;yb(1)-2];
options = bvpset('NMax',400000);
sol=bvp5c(odefun,bcfun,sinit,options);
x=linspace(0,4,101);
y=deval(sol,x);
plot(x,y(1,:),sol.x,sol.y(1,:),'o',sinit.x,sinit.y(1,:),'s')
legend('解曲线L','l解点','粗略解')