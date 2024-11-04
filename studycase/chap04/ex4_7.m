Num = 6;
Mat = magic(4)				%生成一个4×4的矩阵Mat
try
    Mat_Num = Mat(Num,:)		%取Mat的第Num行元素
catch
    Mat_end = Mat(end,:)		%若Mat没有第Num行元素，则取Mat的最后一行元素
end
lasterr						%显示出错原因
