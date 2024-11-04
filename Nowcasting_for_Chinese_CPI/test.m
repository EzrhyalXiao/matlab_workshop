DATA1 = readtable('C:\Users\ASUS\Desktop\datas_iFinD\data1.xlsx');%读取数据，尽量用英文命名变量
date=datetime(table2array(DATA1(1:end,1)));
cpi=table2array(DATA1(1:end,2));
y=table2array(DATA1(1:end,3:end));
figure('Name','Common Factor and Standardized Data');
plot(date,normalize(y),':','LineWidth',1.15); hold on;

A=plot(date,normalize(cpi),'r','LineWidth',1.5); 

xlim(date([1 end])); datetick('x','yyyy','keeplimits');
title('标准化CPI与代理指标')
legend(A,'CPI',Location='South'); 
legend boxoff;
hold off