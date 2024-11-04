fid=fopen('tob.bin','w');
count=fwrite(fid,magic(6),'int32');
fid=fopen('tob.bin','r');
data=(fread(fid,[6,6],'int32'))
