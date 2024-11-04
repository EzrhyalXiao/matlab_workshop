x=-2:2;
Y=[6 8 7 4 5;4 8 1 12 0;4 6 21 1 3];
subplot(1,2,1),bar(x',Y','stacked')
xlabel('x'),ylabel('\Sigma y'),colormap(cool)
legend('ÒòËØ1','ÒòËØ2','ÒòËØ3')
subplot(1,2,2),barh(x',Y','grouped')
xlabel('y'),ylabel('x')
