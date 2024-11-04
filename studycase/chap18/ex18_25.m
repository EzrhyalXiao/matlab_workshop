fid=fopen('t.m','r')  %打开文件
data=fread(fid);    %读文件
disp((data'))    %显示内容
