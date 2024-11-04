clear all;
A=[2 4 5;8 9 6;1 3 5];
[Q1,R1]=qr(A)
B=[2 4 5;8 9 6;1 3 5;5 4 10];
B_rank=rank(B);
disp(['¾ØÕóB µÄÖÈ = ',num2str(B_rank)]);
[Q2,R2]=qr(B)
Q1*R1
