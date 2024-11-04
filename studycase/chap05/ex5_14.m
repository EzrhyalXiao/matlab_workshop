X = (0:1800)*pi/180; Y = cos(X/2);
figure(1)
subplot(1,3,1); plot(X, Y, 'LineWidth', 2); xlim([0 30]); grid on;
subplot(1,3,2); plot(X, Y, 'LineWidth', 2); xlim([0 30]); grid on; grid;
subplot(1,3,3); plot(X, Y, 'LineWidth', 2); xlim([0 30]); grid; grid off;
