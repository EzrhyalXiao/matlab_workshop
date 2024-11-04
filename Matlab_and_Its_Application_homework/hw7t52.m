A=imread('C:\Users\ASUS\Documents\MATLAB\images\lena.jpg'); %图像读入函数（MATLAB自带图像）
shuiyin=imread('C:\Users\ASUS\Documents\MATLAB\images\shuiyin.jpg');
%W=rgb2gray; %RGB（彩色）图像转换成灰度图像
%A=imread('C:\Users\HUAWEI\Desktop\lena.jpg');
%shuiyin=imread('C:\Users\HUAWEI\Desktop\shuiyin.jpg');

jpg=rgb2gray(A);
a=0.05;
shuiyin=rgb2gray(shuiyin);
[m,n]=size(shuiyin);
Ak=jpg(1:m,1:n);
[u,s,v]=svd(double(Ak));
sd=s+a*double(shuiyin);
[u1,s1,v1]=svd(double(sd));
Ak=u*s1*v';
jpg(1:m,1:n)=Ak(1:m,1:n);
imshow(jpg)

Ak2=jpg(1:m,1:n);
[~,s1,~]=svd(double(Ak2));
s3=u1*s1*v1';
W=(s3-s)/a;
imshow(W)