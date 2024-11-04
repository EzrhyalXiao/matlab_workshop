load woman
%使用db1小波对图像进行三层小波分解
[swa,swh,swv,swd]=swt2(X,3,'db1');
mzero=zeros(size(swd));
A=mzero;
%使用iswt2的滤波器功能，重建第3层的近似系数。为了避免iswt的合成运算，注意在重建过程中应保证其他各项系数为零
A(:,:,3)=iswt2(swa,mzero,mzero,mzero,'db1');
H=mzero;V=mzero;D=mzero;
for i=1;3
swcfs=mzero;swcfs(:,:,i)=swh(:,:,i);
H(:,:,i)=iswt2(mzero,swcfs,mzero,mzero,'db1');
swcfs=mzero;swcfs(:,:,i)=swv(:,:,i);
V(:,:,i)=iswt2(mzero,mzero,swcfs,mzero,'db1');
swcfs=mzero;swcfs(:,:,i)=swh(:,:,i);
H(:,:,i)=iswt2(mzero,mzero,mzero,swcfs,'db1');
end
%分别重建1~3级的各个细节系数，同样在重建某一系数的时候，要令其他系数为0
A(:,:,2)=A(:,:,3)+H(:,:,3)+V(:,:,3)+D(:,:,3);
A(:,:,1)=A(:,:,2)+H(:,:,2)+V(:,:,2)+D(:,:,2);
%使用递推的方法建立第1层和第2层近似系数
colormap(map)
kp=0;
for i=1：3
subplot(3,4,kp+1),image(wcodemat(A(:,:,i),192));
title(['第',num2str(i),'层近似系数图像'])
subplot(3,4,kp+2),image(wcodemat(H(:,:,i),192));
title(['第',num2str(i),'层水平细节系数图像'])
subplot(3,4,kp+3),image(wcodemat(V(:,:,i),192));
title(['第',num2str(i),'层竖直细节系数图像'])
subplot(3,4,kp+4),image(wcodemat(D(:,:,i),192));
title(['第',num2str(i),'层对角细节系数图像'])
kp=kp+4;
end
%画出通过手工方法重建的各级小波系数图像
err=norm(A(:,:,2)-swa(:,:,2))
%求出用这种算法重建的第2层近似系数和分解系数之间的误差
