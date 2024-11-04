%准备数据
x1 = [0:.1:40];
y1 = 4.*cos(x1)./(x1+2);
x2 = [1:.2:20];
y2 = x2.^2./x2.^3;
%显示第一个坐标轴对象
hl1 = line(x1,y1,'Color','r'); 
ax1 = gca;
set(ax1,'XColor','r','YColor','r')				%参考图20-18（a）
%添加第二个坐标轴显示对象
ax2 = axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
hl2 = line(x2,y2,'Color','k','Parent',ax2) 		%参考图20-18（b）
xlimits1 = get(ax1,'XLim');
ylimits1 = get(ax1,'YLim');
xinc1 = (xlimits1(2)-xlimits1(1))/5;
yinc1= (ylimits1(2)-ylimits1(1))/5; 				
xlimits2 = get(ax2,'XLim');
ylimits2 = get(ax2,'YLim');
xinc2 = (xlimits2(2)-xlimits2(1))/5;
yinc2 = (ylimits2(2)-ylimits2(1))/5;
%设置标度显示
set(ax1,'XTick',[xlimits1(1):xinc1:xlimits1(2)],...
        'YTick',[ylimits1(1):yinc1:ylimits1(2)]) 	%参考图20-18（c）
set(ax2,'XTick',[xlimits2(1):xinc2:xlimits2(2)],...
        'YTick',[ylimits2(1):yinc2:ylimits2(2)]) 	%参考图20-18（c）
%显示栅格
grid on	%参考图20-18（d）
