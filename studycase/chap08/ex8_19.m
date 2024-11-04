r = normrnd(10,1,200,1);
histfit(r)
h = get(gca,'Children');
set(h(2),'FaceColor',[.8 .8 1])
figure
histfit(r,20)
h = get(gca,'Children');
set(h(2),'FaceColor',[.8 .8 1])
