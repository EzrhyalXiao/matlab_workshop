function y=myth(x)
a=0;
for i=1:1:length(x)
    a=a+mean(x(i));
end
y=a/length(x);
