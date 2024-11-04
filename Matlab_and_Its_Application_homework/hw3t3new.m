xx=[5.764 6.286 6.759 7.168 7.480];
yy=[0.648 1.202 1.823 2.526 3.360];
[theta,rho]=cart2pol(xx,yy);
f=@(canshu) sum((rho-canshu(1)*(1-canshu(2)^2)./(1-canshu(2)*cos(theta+canshu(3)))).^2);
the=0:2*pi/100:2*pi;
canshu=fmincon(f,[2,0.5,2]);
%canshu=[5,0.8,5.64];
g=@(x) canshu(1)*(1-canshu(2)^2)./(1-canshu(2)*cos(x+canshu(3)));
polarplot(the,g(the))
%polarscatter(theta,g(theta))
hold on
polarscatter(theta,rho)
h=legend('$r=\frac{{a(1-e^2)}}{{1-ecos(t+t_0)}}$','data points');
annotation('textbox',[.85 .5 .1 .2], 'String','a=%f,canshu(1)','EdgeColor','none')
set(h,'Interpreter','latex','Location','SouthOutside')
hold off