[X,Y,Z]=peaks(30);
subplot(1,2,1);surfl(X,Y,Z) , colormap(copper) , title('Default Lighting') , shading interp
subplot(1,2,2);surfl(X,Y,Z,[-90  30],[.55  .6  2  10]) , shading interp
