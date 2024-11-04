clear all
clc
A=magic(4)
fid=fopen('dota.txt','w');%open file
fprintf(fid,'%d\n','int8',A)% write a to file
fclose(fid);
fid=fopen('dota.txt','r');%open file
frewind(fid);%将指针放在文件开头
if feof(fid)==0%如果没有到文件结尾，读取数据
[b,count1]=fscanf(fid,'%d\n')%把数据写入b
position=ftell(fid)%获取当前指针位置
end
if feof(fid)==1%如果到文件结尾，重新设置指针
status=fseek(fid,-4,'cof')%把指针从但却位置向文件头移动4个位置
[c,count2]=fscanf(fid,'%d\n')
end
fclose(fid);
