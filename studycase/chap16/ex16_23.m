hb = bar(rand(5)); 		     %创建5个barseries对象，参考图20-26（a）
hg = hggroup;
set(hb(1:4),'Parent',hg) 	%设置barseries对象为hggroup对象的子对象
set(hg,'Visible','off') 		%消隐对象群中的对象，参考图20-26（b）

