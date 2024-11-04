f=@(x) exp(x.^2);
exact=integral(f,-1,1);
guass4(f)


function[re4]=guass4(f)
x=[-0.8611363 -0.3399810 0.3399810 0.8611363];
w=[0.3478548;0.6521452;0.3478548;0.6521452];
re4=f(x)*w;
end