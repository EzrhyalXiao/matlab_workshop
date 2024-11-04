[X,Y,Z] = peaks(30);
figure
subplot(2,2,1);contour(X,Y,Z);axis square
subplot(2,2,2);contour(X,Y,Z,10);axis square
subplot(2,2,3);contour(X,Y,Z,-10:1:10);axis square
subplot(2,2,4);contour(X,Y,Z,':');axis square
