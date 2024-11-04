load facets
%画出原始图像
subplot(121);image(X);colormap(map);
title('原始图像');
axis square
%下面进行图像的增强处理
%用小波函数sym4对X进行二层小波分解
[c,s]=wavedec2(X,2,'sym4');
sizec=size(c);
%对分解系数进行处理以突出轮廓部分，弱化细节部分
for i=1:size(2)
   if(c(i)>350)
      c(i)=2*c(i);
   else
      c(i)=0.5*c(i);
   end
end
%下面对处理后的系数进行重构
xx=waverec2(c,s,'sym4');
%画出重构后的图像
subplot(122);image(xx);
colormap(map);
title('增强图像');
axis square
