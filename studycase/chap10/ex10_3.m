%初始化
function pop=initpop(popsize,chromlength)  
pop=round(rand(popsize,chromlength));  
% rand随机产生每个单元为{0,1}行数为popsize，列数为chromlength的矩阵，
% roud对矩阵的每个单元进行圆整。这样产生的初始种群。
end
function pop2=decodebinary(pop)
[px,py]=size(pop); 
%求pop行和列数
for i=1:py
pop1(:,i)=2.^(py-i).*pop(:,i);
end
pop2=sum(pop1,2); 
%求pop1的每行之和 
end
%将二进制编码转换成十进制
function pop2=decodechrom(pop,spoint,length)
pop1=pop(:,spoint:spoint+length-1);
pop2=decodebinary(pop1);
end
function [objvalue]=calobjvalue(pop)
temp1=decodechrom(pop,1,10); 		%将pop每行转化成十进制数
x=temp1*10/1023; 				%将二值域 中的数转化为变量域 的数
objvalue=10*sin(5*x)+7*cos(4*x); 	%计算目标函数值
end
%计算个体的适应值  
function fitvalue=calfitvalue(objvalue)
global Cmin;
Cmin=0;
[px,py]=size(objvalue);
for i=1:px
    if objvalue(i)+Cmin>0
        temp=Cmin+objvalue(i);
    else
        temp=0.0;
    end
    fitvalue(i)=temp;
end
fitvalue=fitvalue'
%选择复制  
function [newpop]=selection(pop,fitvalue)
totalfit=sum(fitvalue); 		%求适应值之和
fitvalue=fitvalue/totalfit; 	%单个个体被选择的概率
fitvalue=cumsum(fitvalue); 	%如 fitvalue=[1 2 3 4]，则 cumsum(fitvalue)=[1 3 6 10] 
[px,py]=size(pop);
ms=sort(rand(px,1)); 			%从小到大排列
fitin=1;
newin=1;
while newin<=px
    if(ms(newin))<fitvalue(fitin)
        newpop(newin)=pop(fitin);
        newin=newin+1;
    else
        fitin=fitin+1;
    end
end
%交叉  
function [newpop]=crossover(pop,pc)
[px,py]=size(pop);
newpop=ones(size(pop));
for i=1:2:px-1
    if(rand<pc)
        cpoint=round(rand*py);
        newpop(i,:)=[pop(i,1:cpoint),pop(i+1,cpoint+1:py)];
        newpop(i+1,:)=[pop(i+1,1:cpoint),pop(i,cpoint+1:py)];
    else
        newpop(i,:)=pop(i);
        newpop(i+1,:)=pop(i+1);
    end
end  
%变异  
function [newpop]=mutation(pop,pm)
[px,py]=size(pop);
newpop=ones(size(pop));
for i=1:px
    if(rand<pm)
        mpoint=round(rand*py);
        if mpoint<=0
            mpoint=1;
        end
        newpop(i)=pop(i);
        if any(newpop(i,mpoint))==0
            newpop(i,mpoint)=1;
        else
            newpop(i,mpoint)=0;
        end
    else
        newpop(i)=pop(i);
    end
end
%求出群体中适应值最大的值  
function [bestindividual,bestfit]=best(pop,fitvalue)
[px,py]=size(pop);
bestindividual=pop(1,:);
bestfit=fitvalue(1);
for i=2:px
    if fitvalue(i)>bestfit
        bestindividual=pop(i,:);
        bestfit=fitvalue(i);
    end
end
%主程序
clear all
clc 
popsize=20; 								%群体大小  
chromlength=10; 							%字符串长度（个体长度） 
pc=0.7;   								%交叉概率
pm=0.005;                                 		%变异概率
pop=initpop(popsize,chromlength);    		%随机产生初始群体 
for i=1:20                                  		%20为迭代次数
[objvalue]=calobjvalue(pop);            		%计算目标函数 
fitvalue=calfitvalue(objvalue);         		%计算群体中每个个体的适应度
[newpop]=selection(pop,fitvalue);      		%复制 
[newpop]=crossover(pop,pc);              		%交叉 
[newpop]=mutation(pop,pc);              		%变异 
[bestindividual,bestfit]=best(pop,fitvalue);	%求出群体中适应值最大的个体及其适应值
y(i)=max(bestfit); 
n(i)=i;  
pop5=bestindividual;  
x(i)=decodechrom(pop5,1,chromlength)*10/1023; 
pop=newpop; 
end  
fplot('9*sin(5*x)+8*cos(4*x)',[0 15])
hold on
plot(x,y,'r*')
hold off
