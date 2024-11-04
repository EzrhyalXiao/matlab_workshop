X = -10:0.1:10; Y = -10:0.1:10;
[X,Y] = meshgrid(X,Y);
Z = - X.^2 - Y.^2 + 200;
mesh(X,Y,Z)
