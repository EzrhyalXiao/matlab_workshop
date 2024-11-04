syms x ;
result1=limit(cos(x)^(1/x^3),x,0,'right');


syms x y;
f2=log(x)+exp(y^2/x);
result2=simplify(-diff(f2,x)/diff(f2,y));

syms t a;
result3=diff(a*(t^3-sin(t)^2),t)/diff(a*(t-cos(t)),t);

syms x y z;

f4=sin(x+y)+cos(y^2+z^2)+tan(x+z^3);
result4_1=-diff(f4,x)/diff(f4,z);
result4_2=-diff(f4,y)/diff(f4,z);

u=cos(x+y)*exp(x^2*y*sin(z));

du=diff(diff(diff(u,x,2),y,2),z,1);

result5=subs(du,{x,y,z},{0,2,1});

result6=simplify(int(sin(x)^10,x));

result7=int(int(2*x^2*cos(x*y)^2+3*x^2*y^2,y,0,x),0,3);
