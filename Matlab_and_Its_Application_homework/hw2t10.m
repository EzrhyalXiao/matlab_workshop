syms a1 a2 b1 b2 c1 c2 x y;
eqs=[a1*x+b1*y==c1,a2*x+b2*y==c2];
[x_sol,y_sol] = solve(eqs) ;

fprintf('x = ');
disp(x_sol);
fprintf('y = ');
disp(y_sol);
x_cer=eval(subs(x_sol,{a1,a2,b1,b2,c1,c2},{1,2,3,4,5,6}));
y_cer=eval(subs(y_sol,{a1,a2,b1,b2,c1,c2},{1,2,3,4,5,6}));

A=[1 2 3;4 1 2;3 5 1];
[V,D]=eig(A);
fprintf('行列式的值： ');
disp(det(A));
for i=1:3
    fprintf('特征值： ');
    disp(D(i,i));
    fprintf('对应特征向量： ');
    disp(V(1:3,i)');
end
