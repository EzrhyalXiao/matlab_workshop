%脚本文件
array = zeros(1,32);
for n = 3:32					%for循环的运用
array (n) = rank(magic(n));
end
array
bar(array)					%用柱状图输出结果
