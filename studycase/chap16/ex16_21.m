[x,y,z] = peaks;
subplot(121)
[c,h] = contour(x,y,z);
set(h,'LineWidth',3,'LineStyle',':')
subplot(122)
surf(x,y,z);
