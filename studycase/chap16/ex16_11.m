t = 0:pi/20:2*pi;
s = sin(t);
c = cos(t);
% 设置Axes对象的Color属性
figh = figure('Position',[30 100 800 350],... 
              'DefaultAxesColor',[.8 .8 .8]); 
axh1 = subplot(1,2,1); grid on
% 设置第一个Axes对象的LineStyle属性
set(axh1,'DefaultLineLineStyle','-.')
line('XData',t,'YData',s) 
line('XData',t,'YData',c) 
text('Position',[3 .4],'String','Sine')
text('Position',[2 -.3],'String','Cosine',...
     'HorizontalAlignment','right')
axh2 = subplot(1,2,2); grid on
% 设置第二个Axes对象的文字旋转属性
set(axh2,'DefaultTextRotation',90)
line('XData',t,'YData',s) 
line('XData',t,'YData',c) 
text('Position',[3 .4],'String','Sine')
text('Position',[2 -.3],'String','Cosine',...
     'HorizontalAlignment','right')
