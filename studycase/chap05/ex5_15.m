figure
x = 0:0.01*pi:pi*4; y = 0:pi:pi*8;
subplot(1,2,1)
plot(x,sin(x),'r:','LineWidth',3);hold on;
plot(x,2*sin(x/2),'b','LineWidth',3);hold on;
plot(y,sin(y),'g^','MarkerSize',10,'LineWidth',3);hold on;
plot(y,2*sin(y/2),'mo','MarkerSize',10,'LineWidth',3);hold on;xlim([0 pi*4])
subplot(1,2,2)
plot(x,sin(x),'r:','LineWidth',3);
plot(x,2*sin(x/2),'b','LineWidth',3);hold on;
plot(y,sin(y),'g^','MarkerSize',10,'LineWidth',3);
plot(y,2*sin(y/2),'mo','MarkerSize',10,'LineWidth',3);hold on;xlim([0 pi*4])
