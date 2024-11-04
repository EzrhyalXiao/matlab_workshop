clear all
%定义一个具有实数和复数的矩阵
A=[2 6.5 3i 3.5 6 4+2i];
%定义存储实数和复数的矩阵目前为空矩阵
real_array=[];
complex_array=[];
for i=1:length(A),
	%判断矩阵元素是否为实数
	if isreal(A(i))==1,
		real_array=[real_array A(i)];
		else
		complex_array=[complex_array A(i)];
		end;
end;
%输出实数元素
real_array
%输出复数元素
complex_array
