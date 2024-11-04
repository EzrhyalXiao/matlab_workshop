%block=[1 8 1;-7 -4 2;0 0 5; 8 -1 1];%可修改，每行依次为障碍圆的横坐标、纵坐标、半径
R=4;
block=[];
x0=[-4 0];
v0=[1 -1];
v0=v0/norm(v0);
n=5000;
step=0.05;
p=animatedline(x0(1),x0(2),'color','b',...
'linestyle','none','marker','.','markersize',5);
axis([-R,R,-R,R])
xlabel('x-axis')
ylabel('y-axis')

for i=1:1:size(block,1)
rectangle('Position',[block(i,1)-block(i,3),block(i,2)-block(i,3),2*block(i,3),2*block(i,3)],'Curvature',[1,1],'EdgeColor','r')
end

rectangle('Position',[0-R,0-R,2*R,2*R],'Curvature',[1,1],'EdgeColor','r')

v=v0;
x=x0;
for j=1:1:n
    addpoints(p,x(1),x(2))
    drawnow
    x=x+step*v;
    for i=1:size(block,1)
        theblock=block(i,1:2);
        r=theblock-x;
        if norm(r)<block(i,3)
            r=r/norm(r);
            v=v-2*dot(v,r)*r;
            v=v/norm(v);
        end
    end
    if norm(x)>R
        r=-x/norm(x);
        v=v-2*dot(v,r)*r;
        v=v/norm(v);
    end
end
