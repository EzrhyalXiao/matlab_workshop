[X,Y,Z]=peaks(30);
R = sqrt(X.^2+Y.^2);
subplot(1,2,1);surf(X,Y,Z,Z);
axis tight
subplot(1,2,2);surf(X,Y,Z,R);
axis tight
