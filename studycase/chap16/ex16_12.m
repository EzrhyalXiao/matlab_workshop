k = 5;
n = 2^k-1;
[x,y,z] = sphere(n);
c = hadamard(2^k);
surf(x,y,z,c);%²Î¿¼Í¼20-13£¨a£©
colormap([1  1  0; 0  1  1])
axis equal %²Î¿¼Í¼20-13£¨b£©
