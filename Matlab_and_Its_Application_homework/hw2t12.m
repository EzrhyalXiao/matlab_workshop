syms x
n=10;
P=sym('P',[n+1 1]);
P(1)=poly2sym(1,x);
P(2)=poly2sym([1,0],x);

for m=3:1:(n+1)
    P(m)=poly2sym((1/(m-1))*((2*m-3)*[sym2poly(P(m-1)) 0]-(m-2)*[0 0 sym2poly(P(m-2))]),x);
end


fplot(P(1),[-1,1]);
hold on
for i=2:1:(n+1)
  fplot(P(i),[-1,1]);
end


legend('p_0(x)','p_1(x)','p_2(x)','p_3(x)','p_4(x)','p_5(x)',...
       'p_6(x)','p_7(x)','p_8(x)','p_9(x)','p_{10}(x)', 'Location','Southeast');
title('Legendre Polynomials');
xlabel('x');
ylabel('p_n(x)');


for i = 1:(n+1)
    fprintf('p_%d(x) = ',i-1);
    disp(P(i));
    fprintf('Zeros: ');
    disp(sort(roots(sym2poly(P(i))))')
end