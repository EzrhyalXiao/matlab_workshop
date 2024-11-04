iptsetpref('ImshowAxesVisible','on')
ph = phantom(128);
subplot(121);imshow(ph)
[F,Fpos,Fangles] = fanbeam(ph,250);
subplot(122);imshow(F,[],'XData',Fangles,'YData',Fpos,...
            'InitialMagnification','fit')
axis normal
xlabel('Rotation Angles (degrees)')
ylabel('Sensor Positions (degrees)')
colormap(hot), colorbar
