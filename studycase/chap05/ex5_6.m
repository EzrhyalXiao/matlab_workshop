clear
for i=1:5
    for j=1:6
        A(i,j)=i+j;
    end
end
x = 0.2:0.2:1;
figure(1)
subplot(2,2,1); plot(A,x,'LineWidth',1.5);
subplot(2,2,2); plot(x,A,'LineWidth',1.5);
B = reshape(1:30,5,6);
subplot(2,2,3); plot(A,B,'LineWidth',1.5);
subplot(2,2,4); plot(B,A,'LineWidth',1.5);
