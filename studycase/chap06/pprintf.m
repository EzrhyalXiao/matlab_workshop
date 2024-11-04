function s=pprintf (p)
%  pprintf: for polynomial printf.
%  pprintf(p) printf p as string
%  2012.01.23
if nargin>1
     error('Too much input arguments ')  %  确认输入变量
end
while p(1)==0          %  将高次的零去掉
    p(1)=[];
end
l=length(p);         %  计算p的长度
if l==0
    s='0';
elseif l==1
    s=num2str(p(1));
elseif l==2
    s=strcat(num2str(p(1)),'x+',num2str(p(2)));
elseif l>2
    for i=1:l
        if i==1
            if p(i)==1
                s=strcat('x^{',num2str(l-i),'}');
            else
                s=strcat(num2str(p(i)),'x^{',num2str(l-i),'}');
            end
        elseif i==l
            s=strcat(s,'+',num2str(p(i))');
        elseif i==l-1
            s=strcat(s,'+',num2str(p(i)),'x');
        else
            if p(i)==0
            else
                s=strcat(s,'+',num2str(p(i)),'x^{',num2str(l-i),'}');
            end
        end
    end
end
