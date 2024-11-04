function[selected,weight] = search2(Res,Variable,K_min)
index=0;
for i=1:size(Res.y,2)+1
    name=string(Res.Name{i});
    if name==Variable
        index=i-1;
    end
end
if index==0
    fprintf('请输入正确的变量名。')
end

loading=Res.A(:,index);
weight=(loading'*Res.K);
selected=(abs(weight)>K_min);

end
