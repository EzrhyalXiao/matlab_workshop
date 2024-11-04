a = 0.1:0.1:5; x = log10(a); y = 10.^a;
figure
subplot(1,2,1);loglog(x,y,'+','MarkerSize',5,'LineWidth',2);title('lgy = 10^x')
subplot(1,2,2);plot(x,y,'+','MarkerSize',5,'LineWidth',2);title('lgy = 10^x')
