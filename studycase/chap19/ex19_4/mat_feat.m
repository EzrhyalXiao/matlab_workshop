function mat_feat(f_name)								%<1>
disp('被分析矩阵')										%<2>
A=magic(4)							
N=8;								
n=size(f_name,2);					
ff_name=[f_name blanks(N-n)];	
if ff_name==['my_det' blanks(2)]
   disp('矩阵 A 的行列式值 = ')
elseif ff_name==['rank' blanks(4)]
   disp('矩阵 A 的秩 = ')
elseif ff_name==['norm' blanks(4)]
   disp('矩阵 A 的2-范数 = ')
elseif ff_name==['cond' blanks(4)]
   disp('矩阵 A 的条件数 = ')
elseif ff_name==['eig' blanks(5)]
   disp('矩阵 A 的特征值 = ')
elseif ff_name==['svd' blanks(5)]
   disp('矩阵 A 的奇异值 = ')
else
disp('您输入的指令，或者不是本函数文件所能解决的，或是错误的！')
end
d=feval(f_name,A);
disp(d)
