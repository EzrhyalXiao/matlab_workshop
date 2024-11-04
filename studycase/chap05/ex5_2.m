X1 = (0:12)*pi/6; Y1 = cos(3*X1);
X2 = (0:360)*pi/180; Y2 = cos(3*X2);
figure(1)
subplot(2,2,1); plot(X1, Y1, 'o', 'MarkerSize', 3); xlim([0 2*pi])
subplot(2,2,2); plot(X1, Y1, 'LineWidth', 2); xlim([0 2*pi])
subplot(2,2,3); plot(X2, Y2, 'o', 'MarkerSize', 3); xlim([0 2*pi])
subplot(2,2,4); plot(X2, Y2, 'LineWidth', 2); xlim([0 2*pi])
