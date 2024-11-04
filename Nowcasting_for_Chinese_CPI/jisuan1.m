f=@(x) pi*(exp(-x.^2)+1).^2-pi;
integral(f,-4,4,'AbsTol',1e-18);
a=[0, 19, 58, 77, 94, 105, 116, 129, 63, 40,0];
f=@(x) 16*pi*(pi-x).*cos(x).^4;
f=@(x) 4*pi*x.^2.*exp(-x);
f=@(x) 2*pi*(x-3).*(9*x-18+x.^2);
jieguo=round(integral(f,3,6,'AbsTol',1e-18),5);
f=@(x) 2*pi*x.*sqrt(4+2*x.^3);
wei=f(0:1/5:1);
jisuan=size(5,1);
for i=1:5
    jisuan(i)=(wei(i)+wei(i+1))*0.1;
end
round(sum(jisuan),3)