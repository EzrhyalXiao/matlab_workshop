A = [2 0 -1;1 3 2]
B = [1 7 -1;4 2 3;2 0 1]
C = [1 0 1 0;-1 2 0 1]
MAB1 = cat(1,A,B) % 将矩阵A、B按行合并

MAC2 = cat(2,A,C) % 将矩阵A、C按列合并