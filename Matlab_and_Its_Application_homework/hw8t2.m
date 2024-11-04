line([0,0],[0,1])
r=1;
theta=0;
dian=[0;1];
thetas=[-pi/6,pi/7,pi/8];
tree(6,r,theta,dian,thetas)
axis([-2,2,0,4])

function[]=tree(n,r,theta,dian,thetas)
theta1=thetas(1);
theta2=thetas(2);
theta3=thetas(3);
dian1=dian+0.5*r*xuan(theta1+theta)*[0;1];
dian2=dian+0.5*r*xuan(theta2+theta)*[0;1];
dian3=dian+0.25*r*xuan(theta2+theta)*[0;1];
dian4=dian3+0.25*r*xuan(theta2+theta3+theta)*[0;1];
line([dian(1) dian1(1)],[dian(2) dian1(2)]);
line([dian(1) dian2(1)],[dian(2) dian2(2)]);
line([dian3(1) dian4(1)],[dian3(2) dian4(2)]);
if n>1
    tree(n-1,0.5*r,theta1+theta,dian1,thetas)
    tree(n-1,0.5*r,theta2+theta,dian2,thetas)
    tree(n-1,0.25*r,theta3+theta2+theta,dian4,thetas)
end

end


function[A]=xuan(theta)
A=[cos(theta) sin(theta);-sin(theta) cos(theta)];
end
