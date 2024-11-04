function spir_len = spirallength(d, n, lcolor)
%CIRCLE plot a circle of radius as r in the provided color and calculate its area
% d：螺旋的旋距
%   n：螺旋的圈数
%   lcolor：画图线的颜色
%   spir_len：螺旋的周长
% spirallength(d, n)：利用蓝色以预设参数的螺旋线
% spirallength(d, n,lcolor)：利用lcolor颜色以预设参数的螺旋线
% spir_len = spirallength(d, n)：计算螺旋线的周长，并用蓝色填充螺旋线
% spir_len = spirallength(d, n,lcolor)：计算螺旋线的周长，并用lcolor颜色填充螺旋线
% 编写于2009.7.6，修改于2011.8.8			程序员：01
if nargin > 3
    error('输入变量过多！');
elseif nargin == 2
    lcolor = 'b';
end
j = sqrt(-1);
phi = 0: pi/1000 : n*2*pi;
amp = 0: d/2000 : n*d;
spir = amp .* exp(j*phi);
if nargout == 1
    spir_len = sum(abs(diff(spir)));
    fill(real(spir), img(spir), lcolor)
elseif nargout == 0
    plot(spir,lcolor)
else
    error('输出变量过多！');
end
axis('square')
