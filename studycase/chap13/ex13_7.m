%装入一个二维信号
load wbarb
%显示图像
subplot(121);image(X);colormap(map)
title('原始图像');
axis square
%下面进行图像压缩
%对图像用db3小波进行二层小波分解
[c,s]=wavedec2(X,2,'db3');
%使用wavedec2函数来实现图像的压缩
[thr,sorh,keepapp]=ddencmp('cmp','wv',X);
%输入参数中选择了全局阈值选项“gbl”，用来对所有高频系数进行相同的阈值量化处理
[Xcomp,cxc,lxc,perf0,perfl2]=wdencmp('gbl',c,s,'db3',2,thr,sorh,keepapp);
%将压缩后的图像与原始图像相比较，并显示出来
subplot(122);image(Xcomp);colormap(map)
title('压缩图像');
axis square
disp('小波分解系数中置0的系数个数百分比：');
perf0
disp('压缩后图像剩余能量百分比：');
perfl2
