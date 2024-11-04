clear all
A=[1 2 3;3 4 5;7 8 9];
B=magic(5);
r1=trace(A);					%¾ØÕóµÄ¼£
r2=trace(B);
disp(['AµÄ¼£=',num2str(r1)]);
disp(['BµÄ¼£=',num2str(r2)]);
