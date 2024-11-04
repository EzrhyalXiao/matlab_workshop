load woman;
X1=X;map1=map;
%画出原始图像
subplot(221);image(X1);colormap(map1);
title('woman');
axis square
load facets;
X2=X;map2=map;
for i=1:256
   for j=1:256
      if (X2(i,j)>100)
         X2(i,j)=1.2*X2(i,j);
      else
         X2(i,j)=0.5*X2(i,j);
      end
   end
end
subplot(222);image(X2);colormap(map2);
title('facets');
axis square
%用小波函数sym4对X1进行二层小波分解
[c1,s1]=wavedec2(X1,2,'sym4');
%对分解系数进行处理以突出轮廓部分，弱化细节部分
sizec1=size(c1);
for i=1：sizec1(2)
   c1(i)=1.2*c1(i);
end
%用小波函数sym4对X2进行二层小波分解
[c2,s2]=wavedec2(X2,2,'sym4');
%下面进行小波变换域的图像融合
c=c1+c2;
%减小图像亮度
c=0.5*c;
%对融合的系数进行重构
xx=waverec2(c,s1,'sym4');
%画出融合后的图像
subplot(223);image(xx);
title('融合图像');
axis square
