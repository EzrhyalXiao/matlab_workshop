load julia
%画出原始图像
subplot(221);image(X);colormap(map);
title('原始图像');
axis square
%产生含噪图像
init=2055615866;randn('seed',init)
x=X+38*randn(size(X));
%画出含噪图像
subplot(222);image(x);colormap(map);
title('含噪声图像');
axis square;
%下面进行图像的去噪处理
%用小波函数sym4对x进行二层小波分解
[c,s]=wavedec2(x,2,'sym4');
%提取小波分解中第一层的低频图像，即实现了低通滤波去噪
a1=wrcoef2('a',c,s,'sym4');
%画出去噪后的图像
subplot(223);image(a1);
title('第一次去噪图像');
axis square;
%提取小波分解中第二层的低频图像，即实现了低通滤波去噪
%相当于把第一层的低频图像经过再一次的低频滤波处理
a2=wrcoef2('a',c,s,'sym4',2);
%画出去噪后的图像
subplot(224);image(a2);title('第二次去噪图像');
axis square;
