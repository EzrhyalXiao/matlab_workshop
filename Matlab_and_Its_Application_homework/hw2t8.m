syms x;
f=exp(x^2)*cos(x)^2*sin(x^2);
t6 = taylor(f, 'Order', 6);
t8 = taylor(f, 'Order', 8);
t10 = taylor(f, 'Order', 10);

plotF = fplot(f, [-1.5, 1.5]); hold on;
plotT6 = fplot(t6, [-1.5, 1.5]);
plotT8 = fplot(t8, [-1.5, 1.5]); 
plotT10 = fplot(t10, [-1.5, 1.5]);
legend('exp(x^2)*cos(x)^2*sin(x^2)','approximation of exp(x^2)*cos(x)^2*sin(x^2) up to O(x^6)',...
'approximation of exp(x^2)*cos(x)^2*sin(x^2) up to O(x^8)',... 
'approximation of exp(x^2)*cos(x)^2*sin(x^2) up to O(x^1^0)',...
'Location', 'South') ;
title('Taylor Series Expansion') ;
hold off
