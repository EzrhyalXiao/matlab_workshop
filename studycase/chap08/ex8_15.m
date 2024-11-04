X = randn(100,25);
subplot(3,1,1)
boxplot(X)
subplot(3,1,2)
boxplot(X,'plotstyle','compact')
subplot(3,1,3)
boxplot(X,'notch','on')
