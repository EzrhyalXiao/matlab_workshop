clear all
fid=fopen('t.m','r');  %打开文件
data=fread(fid,4)    %读文件
data=fread(fid,[3,2])
