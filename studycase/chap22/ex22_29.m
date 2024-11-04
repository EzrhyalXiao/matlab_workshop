x = (1:128).' + 50*cos((1:128).'*2*pi/40);
X = dct(x); 
% 将小于1%能量系数归零，并重建信号 
 [XX, ind] = sort(abs(X),1,'descend');
ii = 1;
while (norm([XX(1:ii);zeros(128-ii,1)]) <= 0.999*norm(XX))
ii = ii+1;
end
disp(['系数和占总能量99%的系数个数为: ',num2str(ii)]); 
XXt = zeros(128,1);
XXt(ind(1:ii)) = X(ind(1:ii));
xt = idct( XXt);
plot(1:128,x,'-.');hold on
plot(1:128, xt);
legend('Original signal','Reconstructed signal', 'location','best');
