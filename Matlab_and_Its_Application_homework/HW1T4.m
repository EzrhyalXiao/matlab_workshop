
%定义系数
p = [1/3, 1/3, 1/3];
m = [0.5 0 0 0.5 0 0;
     0.5 0 0 0.5 0.5 0;
     0.5 0 0 0.5 0.25 0.5];
%迭代次数
n=3000;
%初始化
x = zeros(n+1);
y = zeros(n+1);
x(1)=1;
y(1)=1;
%迭代
for i=1:1:n
    s=rand;
    if s<p(1)
        coeffs=m(1,:);
    elseif s<p(1)+p(2)
        coeffs=m(2,:);
    else
        coeffs=m(3,:);
    end
    x(i+1) = coeffs(1)*x(i) + coeffs(2)*y(i) + coeffs(5);
    y(i+1) = coeffs(3)*x(i) + coeffs(4)*y(i) + coeffs(6);
end

plot(x, y, '.');
axis equal;

