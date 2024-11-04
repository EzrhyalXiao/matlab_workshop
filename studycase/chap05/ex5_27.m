theta = 0:.01*pi:2*pi; x = sin(theta); y = cos(theta); z = cos(4*theta);
figure
plot3(x,y,z,'LineWidth',2);hold on;
theta = 0:.02*pi:2*pi; x = sin(theta); y = cos(theta); z = cos(4*theta);
plot3(x,y,z,'rd','MarkerSize',10,'LineWidth',2)
