x = 0:0.01*pi:pi*0.5; y = cos(x)+sqrt(-1)*sin(x);
plot(y*2,'r','LineWidth',5);hold on;
x = pi*0.5:0.01*pi:pi; y = cos(x)+sqrt(-1)*sin(x);
plot(y*2,'y','LineWidth',5);hold on;
x = -pi:0.01*pi:-pi*0.5; y = cos(x)+sqrt(-1)*sin(x);
plot(y*2,'b','LineWidth',5);hold on;
x = -pi*0.5:0.01*pi:0; y = cos(x)+sqrt(-1)*sin(x);
plot(y*2,'g','LineWidth',5);hold on;
title('极坐标系');
text([1.5 -3 1.5 -3],[2 2 -2 -2], {'第一象限','第二象限','第三象限','第四象限'})
legend({'[0  0.5\pi]','[0.5\pi  \pi]','[\pi  1.5\pi]','[1.5\pi  2\pi]'})
xlim([-5 5]);ylim([-5 5]);
plot([-4 4],[0 0],'k','LineWidth',3);hold on;
plot([0 0],[-4 4],'k','LineWidth',3);hold on;
axis off
