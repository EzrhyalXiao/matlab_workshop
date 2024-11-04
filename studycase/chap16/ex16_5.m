x=0:0.01:6.28;
y=sin(x);
figure;plot(x,y)
text_handle = text('String','\{5\pi\div4, sin(5\pi\div4)\}\rightarrow',...
     'Position',[5*pi/4,sin(5*pi/4),0],'HorizontalAlignment','right')
x1=0.5:0.01:6.78;
y1=sin(x1);
figure;plot(x1,y1)
copyobj(text_handle,gca)