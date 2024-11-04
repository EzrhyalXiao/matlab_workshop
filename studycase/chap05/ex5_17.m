figure
angl = 0:0.01*pi:2*pi;
ampl = sin(0:0.01*pi:2*pi);
z = ampl.*(cos(angl) + sqrt(-1)*sin(angl));
[AX,H1,H2] = plotyy(0:200,abs(z),0:200,angle(z)*180/pi);
set(get(AX(1),'Ylabel'),'String','amplitude') 
set(get(AX(2),'Ylabel'),'String','phase')
set(H1,'LineWidth',3)
set(H2,'LineStyle',':','LineWidth',3)
