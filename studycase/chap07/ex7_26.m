syms x y z;
f1=sym('exp(x*sin(y))+log(z)')
diff(f1,x)
diff(f1,y)
diff(f1,z)
diff(f1,x,2)
f2=sym('[x^2+y^2;y*z]')
J=jacobian(f2,[x,y])
