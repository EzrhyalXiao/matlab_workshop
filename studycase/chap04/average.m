function y=average(x)
[a,b]=size(x);						 % 判断输入量的大小
if~((a==1)|(b==1))| ((a==1)& (b==1))  % 判断输入是否为向量
    error('必须输入向量。')
end
y=sum(x)/length(x); 				%计算向量x所有元素的平均值
