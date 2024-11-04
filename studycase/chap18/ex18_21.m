fid=fopen('tob.bin','w');
count=fwrite(fid,magic(6),'int32');
status=fclose(fid)
fid=fopen('tob.bin','r')
data=(fread(fid,36,'int32'))
