function y1=Flower(n,s)
j = sqrt(-1);
phi = 0 : pi/(20*n) : 2*pi;
amp = 0;
for i = 1 : n
    amp = [amp 1/20:1/20:1 19/20:-1/20:0];
end
y1=subflower(4,s);						%n=4，做出的图片为四瓣的花
%------------  subfunction  -------------
function y2=subflower(n,s)
j = sqrt(-1);
phi = 0 : pi/(20*n) : 2*pi;
amp = 0;
for i = 1 : n
    amp = [amp 1/20:1/20:1 19/20:-1/20:0];
end
func='amp.*exp(j*phi)';
switch s
case {'base','caller'}
   y2=evalin(s,func);
case 'self'
   y2=eval(func);
end
