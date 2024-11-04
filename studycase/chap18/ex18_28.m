fid=fopen('fgetl.m');
while 1
tline = fgetl(fid);
if  ~ ischar(tline)
break;
end
disp(tline)
end
fclose(fid);
