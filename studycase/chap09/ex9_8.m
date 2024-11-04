function [n1,n2]=mythe(m1,m2)
if nargin==1
    n1=m1;
    if nargout==2
        n2=m1;
    end
else
    if nargout==1
        n1=m1+m2;
    else
        n1=m1;
        n2=m2;
    end
end
