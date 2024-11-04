clear all
clc
m=rand(4);
dlmwrite('myfile2.txt',m,'delimiter','\t','precision',5)    %指定精确度
type myfile2.txt
dlmwrite('myfile4.txt',m,'delimiter','\t','precision',3)    %指定精确度
type myfile4.txt
