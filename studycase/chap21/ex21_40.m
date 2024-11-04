subplot(121), imshow('cameraman.tif');
subplot(122), imshow('cameraman.tif');
h = imellipse(gca, [10 10 100 100]);
addNewPositionCallback(h,@(p) title(mat2str(p,3)));
fcn = makeConstrainToRectFcn('imellipse',get(gca,'XLim'),get(gca,'YLim'));
setPositionConstraintFcn(h,fcn);
