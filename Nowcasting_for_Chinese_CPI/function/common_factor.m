function[] = common_factor(Res)
%NOWCAST 此处显示有关此函数的摘要
%   此处显示详细说明
date=Res.date;
f=Res.f;
y=Res.y;
figure('Name','Common Factor and Standardized Data');
plot(date,normalize(y),':'); hold on;

A=plot(date,normalize(f(:,1)),'LineWidth',1.5,'color',[1 0 0]); 

xlim(date([1 end])); datetick('x','yyyy','keeplimits');
%title('标准化潜在因子与原始数据')
xlabel('time')
legend(A,'common factor',Location='south'); 
legend boxoff;
hold off
end

