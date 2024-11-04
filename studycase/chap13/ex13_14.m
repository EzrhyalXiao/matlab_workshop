%读入chess信号
load chess
%分别保存用DCT方法和小波方法的变换系数
blur1=X;
blur2=X;
%对原图像做二维离散余弦变换
ff1=dct2(X);
%对变换结果在频域做BUTTERWORTH滤波
for i=1:256
   for j=1:256
      ff1(i,j)=ff1(i,j)/(1+((i*j+j*j)/8192)^2);
   end
end
%重建变换后的图像
blur1=idct2(ff1);
%对图像做二层的二维小波分解
[c,l]=wavedec2(X,2,'db3');
csize=size(c);
%对低频系数进行放大处理，并抑制高频系数
for i=1:csize(2);
   if(c(i)>300)
      c(i)=c(i)*2;
   else
      c(i)=c(i)/2;
   end
end
%通过处理后的小波系数重建图像
blur2=waverec2(c,l,'db3');
%显示3幅图像
subplot(221);image(wcodemat(X,192));colormap(gray(256));
title('原始图像','fontsize',18);
subplot(223);image(wcodemat(blur1,192));colormap(gray(256));
title('采用DCT方法钝化图像','fontsize',18);
subplot(224);image(wcodemat(blur2,192));colormap(gray(256));
title('采用小波方法钝化图像','fontsize',18);
