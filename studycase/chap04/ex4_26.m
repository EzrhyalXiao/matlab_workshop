clear all; close all; 
n = 6;						%n=6，作出的图片为六瓣的花
j = sqrt(-1);
phi = 0 : pi/(20*n) : 2*pi;
amp = 0;
for i = 1 : n
    amp = [amp 1/20:1/20:1 19/20:-1/20:0];
end
string = {'base', 'caller', 'self'};		%在本例中，字符串为“base”时，
	%调用基本工作区
							%字符串为“caller”时，调用函数空间
							%字符串为“self”时，调用子函数空间
for i=1:3
    y = Flower(5, string{i});		%n=5，作出的图片为5瓣的花
    subplot(1, 3, i)
    plot(y,'r','LineWidth',4)
    axis('square')
end
