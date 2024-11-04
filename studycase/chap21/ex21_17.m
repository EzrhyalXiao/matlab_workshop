f = zeros(30,30);
f(5:24,13:17) = 1;
subplot(221);imshow(f,'InitialMagnification','fit')
F = fft2(f);
F2 = log(abs(F));
subplot(222);imshow(F2,[-1 5],'InitialMagnification','fit');
colormap(jet); colorbar
F = fft2(f,256,256);
subplot(223);imshow(log(abs(F)),[-1 5]); colormap(jet); colorbar
F = fft2(f,256,256);F2 = fftshift(F);
subplot(224);imshow(log(abs(F2)),[-1 5]); colormap(jet); colorbar
