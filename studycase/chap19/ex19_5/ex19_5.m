% Allow a line to have its own 'ButtonDownFcn' callback.创建可来回观察的控件直线
figure; plot(magic(10)); 
hCM = uicontextmenu; 
hMenu = uimenu('Parent',hCM,'Label','Switch to zoom',...
        'Callback','zoom(gcbf,''on'')'); 
hPan = pan(gcf); 
set(hPan,'UIContextMenu',hCM);
