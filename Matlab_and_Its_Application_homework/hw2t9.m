syms y1(x) y2(x) %微分方程组
eqns = [diff(y1,x)==y1-2*y2+x, diff(y2,x)==3*y1+y2]; 
conds= [y1(0)==1,y2(0)==4];
sol = dsolve(eqns,conds);


plot1=fplot(sol.y1,[-2,2]);
hold on 
plot2=fplot(sol.y2,[-2,2]);

set(plot1,'Color','red') ;
set(plot2,'Color','magenta');
legend('y1',... 
'y2',...
'Location', 'South') ;
title('Solution of the system of differential equations') ;
hold off