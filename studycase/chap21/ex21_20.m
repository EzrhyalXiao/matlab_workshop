bw = imread('text.png');
a = bw(32:45,88:98);
subplot(221);imshow(bw);
subplot(222);imshow(a);
C = real(ifft2(fft2(bw) .* fft2(rot90(a,2),256,256)));
subplot(223);imshow(C,[])
max(C(:))
thresh =60; % ÉèÖÃ¹ýÂËãÐÖµ
subplot(224);imshow(C > thresh) 
