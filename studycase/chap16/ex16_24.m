h = surf(peaks(40)); view(-20,30)			%²Î¿¼Í¼20-27£¨a£©
t = hgtransform;
set(h,'Parent',t)
ry_angle = -15*pi/180; 						%Ğı×ª»¡¶È	
Ry = makehgtform('yrotate',ry_angle); 		%ÈÆyÖáĞı×ª¾ØÕó
Tx1 = makehgtform('translate',[-20 0 0]);		%ÑØxÖáÆ½ÒÆ¾ØÕó
Tx2 = makehgtform('translate',[20 0 0]); 		%ÑØxÖáÆ½ÒÆ¾ØÕó
set(t,'Matrix',Tx2*Ry*Tx1) 					%²Î¿¼Í¼20-27£¨b£©
