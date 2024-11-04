[x,y] = meshgrid([-2:.4:2]);
Z = x.*exp(-x.^2-y.^2);
fh = figure('Position',[350 275 400 300],'Color','w');
ah = axes('Color',[1 1 1],'XTick',[-2 -1 0 1 2],...
          'YTick',[-2 -1 0 1 2]);
sh = surface('XData',x,'YData',y,'ZData',Z,...
             'FaceColor',get(ah,'Color')-.2,...
             'EdgeColor','k','Marker','o',...
             'MarkerFaceColor',[.5 1 .85]);	%�ο�ͼ20-23��a��
view(3) 									%�ο�ͼ20-23��b��
