load wmandril
%画出原始图像
subplot(131);image(X);colormap(map);
title('原始图像');
axis square
%产生含噪声图像
init=2055615866;randn('seed',init)
x=X+10*randn(size(X));
%画出含噪声图像
subplot(132);image(X);colormap(map);
title('含噪声图像');
axis square
%下面进行图像的去噪处理
%用小波画数coif3对x进行二层小波分解
[c,s]=wavedec2(x,2,'coif3');
%提取小波分解中第一层的低频图像，即实现了低通滤波去噪
%设置尺度向量n
n=[1,2]
%设置阈值向量p
p=[10.12,23.28];
%对三个方向高频系数进行阈值处理
nc=wthcoef2('h',c,s,n,p,'s');
nc=wthcoef2('v',c,s,n,p,'s');
nc=wthcoef2('d',c,s,n,p,'s');
%对新的小波分解结构[nc,s]进行重构
xx=waverec2(nc,s,'coif3');
%画出重构后图像的波形
subplot(133);image(X);colormap(map);
title('去噪后的图像');
axis square
