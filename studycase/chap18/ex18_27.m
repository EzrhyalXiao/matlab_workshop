a=1:10;
b=[a;nthroot(a,3)];%求一个方根表
fid=fopen('c_table.dat','w');
fprintf(fid,'table ofcube root :\n');
fprintf(fid,'%2.0f %6.4f\n',b);
fclose(fid);
type c_table.dat
