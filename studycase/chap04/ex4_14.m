a(1) = 1;
a(2) = 1;
n = 1000;
for i = 3:n
    a(i) = a(i-1) + a(i-2); 		%求下一项
    if a(i) > 9999
        [i a(i)]
        Break						%当元素大于9999时，退出循环
    end
end
