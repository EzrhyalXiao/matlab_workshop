X1 = [1 2 4 6 7 8 10 11 12 14 16 17 18 20];
Y1 = [1 2 4 6 7 8 10 10 8 7 6 4 2 1];       %生成两个一维实数数组
figure(1)
plot(X1, Y1, 'o', 'MarkerSize', 15)
X2 = 1:20;
Y2 = log(X2);                               %根据log函数生成两个一维实数数组
figure(2)
plot(X2, Y2, 'o', 'MarkerSize', 15)
