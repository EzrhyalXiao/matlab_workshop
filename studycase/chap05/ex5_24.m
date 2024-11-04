x = [1 5 0.5 3.5 2];
explode = [0 1 0 0 0];
pie(x,explode)%绘制饼图
colormap jet
%生成如图所示的二维饼图。
pie3(x,explode)
colormap hsv
