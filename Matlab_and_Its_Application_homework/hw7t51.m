A=imread('C:\Users\ASUS\Documents\MATLAB\images\lena.jpg'); %图像读入函数（MATLAB自带图像）
shuiyin=imread('C:\Users\ASUS\Documents\MATLAB\images\shuiyin.jpg');
%W=rgb2gray; %RGB（彩色）图像转换成灰度图像
%A=imread('C:\Users\HUAWEI\Desktop\lena.jpg');
%shuiyin=imread('C:\Users\HUAWEI\Desktop\shuiyin.jpg');

jpg=rgb2gray(A);
a=0.3;
shuiyin=rgb2gray(shuiyin);
Ak=jpg(1:159,1:219)+a*shuiyin;
%[u,s,v]=svd(double(Ak));
%s=s+a*double(shuiyin);
%[u1,s1,v1]=svd(double(s));
%Ak=u*s1*v';
%jpg(1:159,1:217)=Ak(1:159,1:217);
%A(:,:,2)=jpg;
imshow(A)

