clear all
clc
M = magic(3);
dlmwrite('myfile5.txt', [M*5 M/5], ' ')
type myfile5.txt	%输出myfile5.txt进行第一次观察
dlmwrite('myfile5.txt', rand(3), '-append', 'roffset', 1, 'delimiter', ' ')
type myfile5.txt	%输出myfile5.txt进行第二次观察
