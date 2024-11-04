f_con=@(x) (sqrt(x(1)^2+x(2)^2)-x(3)-10+x(4)^2)^2+(sqrt(x(1)^2+x(2)^2)+x(3)-3+x(5)^2)^2;


options=optimset('PlotFcns',@optimplotfval,'Tolfun',1.0e-8,'Tolx',1.0e-8);
[x,fval,exitflag,output]=fminunc(f_con,[-6,0,-3,0,0],options);
fprintf('最小值为：%f \n',fval);
fprintf('最小值点为：');
disp(x);





f_unc=@(x) 10*x(1)^3+x(1)*x(2)^2+x(3)*(x(1)^2+x(2)^2);
[x2,val2]=fmincon(f_unc,[1,1,0],[],[],[],[],[],[],@my_con);
fprintf('最小值为：%f \n',val2);
fprintf('最小值点为：');
disp(x2);

function[c,ceq]=my_con(x)
c(1)=sqrt(x(1)^2+x(2)^2)-x(3)-10;
c(2)=sqrt(x(1)^2+x(2)^2)+x(3)-3;
ceq=[];
end

