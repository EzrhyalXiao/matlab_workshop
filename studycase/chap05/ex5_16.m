figure
x = 0:0.01*pi:pi*16; j = sqrt(-1);
subplot(2,2,1);plot(abs(sin(x)).*(cos(x)+j*sin(x)),'LineWidth',3);
xlim([-1 1]);ylim([-1 1]);
subplot(2,2,2);plot(abs(sin(x/2)).*(cos(x)+j*sin(x)),'LineWidth',3);
xlim([-1 1]);ylim([-1 1]);
subplot(2,2,3);plot(abs(sin(x/3)).*(cos(x)+j*sin(x)),'LineWidth',3);
xlim([-1 1]);ylim([-1 1]);
subplot(2,2,4);plot(abs(sin(x/4)).*(cos(x)+j*sin(x)),'LineWidth',3);
xlim([-1 1]);ylim([-1 1]);
