[theta,r]=meshgrid(0:2*pi/30:2*pi,0:0.02:1);
[X,Y]=pol2cart(theta,r);

x=2*X;
y=3*Y;

z=x.^2.*y.^3.*cos(2.*x+y);


%等高
meshc(x,y,z);

%着色表面
%surf(x,y,z)

%伪彩
%pcolor(x,y,z);
%colorbar
axis equal
%等高
%contour(x,y,z,'ShowText','on');


