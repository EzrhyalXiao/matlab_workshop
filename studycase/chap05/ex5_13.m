figure
x = 0:0.01*pi:pi*8;
plot(x,sin(x),'r:','LineWidth',3);hold on;
plot(x,2*sin(x/2),'y','LineWidth',3);hold on;
plot(x,4*sin(x/4),'b--','LineWidth',3);hold on;
x = 0:pi:pi*8;
plot(x,sin(x),'g^','MarkerSize',10,'LineWidth',3);hold on;
plot(x,2*sin(x/2),'co','MarkerSize',10,'LineWidth',3);hold on;
plot(x,4*sin(x/4),'msquare','MarkerSize',10,'LineWidth',3);hold on;
xlim([0 pi*8])
