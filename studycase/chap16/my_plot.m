function my_plot(x,y)
cax = newplot;   % 返回当前坐标轴对象的句柄
LSO = ['- ';'--';': ';'-.'];
set(cax,'FontName','Times','FontAngle','italic') 
set(get(cax,'Parent'),'MenuBar','none') 
line_handles = line(x,y,'Color','b');
style = 1;
for i = 1:length(line_handles)
    if style > length(LSO), style = 1;end
    set(line_handles(i),'LineStyle',LSO(style,:))
    style = style + 1;
end
grid on