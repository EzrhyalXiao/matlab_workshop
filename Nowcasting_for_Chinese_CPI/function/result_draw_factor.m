function[] = common_factor(Res)
%NOWCAST 此处显示有关此函数的摘要
%   此处显示详细说明
date=Res.date;
f=Res.f;
y=Res.y;
figure('Name','Common Factor and Standardized Data');
plot(date,normalize(y),':'); hold on;
A=zeros(size(f,2),1);
for i=1:size(f,2)
    A(i)=plot(date,normalize(f(:,i)),'LineWidth',1.5); 
    box on;
end
xlim(date([1 end])); datetick('x','yyyy','keeplimits');
title('标准化潜在因子与原始数据')
legend(A,'因子'+string(1:size(f,2)),Location='SouthOutside'); 
legend boxoff;
hold off
end

