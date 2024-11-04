x = 10.^(0.1:0.1:4);y = 1 ./ (x+1000);
figure
subplot(1,2,1);semilogx(x,y,'+','MarkerSize',5,'LineWidth',2);title('y = (x+1000)^{-1}')
subplot(1,2,2);plot(x,y,'+','MarkerSize',5,'LineWidth',2);title('y = (x+1000)^{-1}')
