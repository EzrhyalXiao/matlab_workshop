A = multibandread('littlecoriver.lan', [512, 512, 7], ...
'uint8=>uint8', 128, 'bil', 'ieee-le', ...
{'Band','Direct',[3 2 1]});
B = decorrstretch(A);
subplot(221);imshow(A)
subplot(222);imshow(B)
rA = A(:,:,1);gA = A(:,:,2);bA = A(:,:,3);
subplot(223);plot3(rA(:),gA(:),bA(:),'.');grid on
xlabel('Red (Band 3)');ylabel('Green (Band 2)');zlabel('Blue (Band 1)')
rB = B(:,:,1);gB = B(:,:,2);bB = B(:,:,3);
subplot(224);plot3(rB(:),gB(:),bB(:),'.');grid on
xlabel('Red (Band 3)');ylabel('Green (Band 2)');zlabel('Blue (Band 1)')
