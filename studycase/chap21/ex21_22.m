iptsetpref('ImshowAxesVisible','on')
I = zeros(100,100);
I(25:75, 25:75) = 1;
theta = 0:180;
[R,xp] = radon(I,theta);
imshow(R,[],'Xdata',theta,'Ydata',xp,...
            'InitialMagnification','fit')
xlabel('\theta (degrees)')
ylabel('x''')
colormap(hot), colorbar
