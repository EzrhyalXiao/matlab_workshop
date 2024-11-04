for i = 1:4
    for j = 1:4
        if i>(5-j)
        else
            Mat(i,j) = i + j - 1;
        end
    end
end
Mat
