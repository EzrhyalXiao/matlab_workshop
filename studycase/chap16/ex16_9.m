set(0,'DefaultSurfaceEdgeColor','k')
h = surface(peaks);             	%使用默认EdgeColor进行绘图，参考图20-10（a）
set(gcf,'DefaultSurfaceEdgeColor','g')
set(h,'EdgeColor','default')   	%设置为新的默认EdgeColor值，参考图20-10（b）
