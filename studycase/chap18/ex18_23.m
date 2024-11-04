A=[1 3;4 5];
fid=fopen('a.txt','w')
count=fwrite(fid,A,'int32') %write data
closestatus=fclose(fid)
 fid=fopen('a.txt','r');       %再次打开文件
data=(fread(fid,[2,2],'int32'))
