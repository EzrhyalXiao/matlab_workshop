clear all
clc
a=[1:10];%创建数组
fid=fopen('six.bin','w');
fwrite(fid,a,'short');%写入文件
status=fclose(fid);%关闭文件
fid=fopen('six.bin','r');
six=fread(fid,'short');%读取文件
eof=feof(fid);%判断测试指针是否在文件结束位置
frewind(fid);%将指针返回到文件开始
status=fseek(fid,3,0);%设定指针位置
position=ftell(fid);%于返回现在的位置指针
six' 
eof 
status 
position
