clear all;
a='LadyGaga ,BAD Romance.'
[fid,message]=fopen('chap.txt','wt');
if fid==-1
    disp(message);
else
    fprintf(fid,'%s',a);
    fclose(fid);
end
[fid,message]=fopen('chap.txt','r');
if fid==-1
    disp(message);
else
    a1=fscanf(fid,'%c',4)
    frewind(fid);
    a2=fscanf(fid,'%c',[3,4])
    frewind(fid)
    a3=fscanf(fid,'%c')
    frewind(fid)
    a4=fscanf(fid,'%s',4)
    frewind(fid)
    a5=fscanf(fid,'%s')
    fclose(fid);
end
