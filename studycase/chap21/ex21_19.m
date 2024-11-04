A = magic(3);
B = magic(4);
A(8,8) = 0;
B(8,8) = 0;
C = ifft2(fft2(A).*fft2(B));
C = C(1:6,1:6);
C = real(C)
