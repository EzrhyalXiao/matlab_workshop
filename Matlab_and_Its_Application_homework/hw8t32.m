h = [0.004717427938400
    -0.017791870101860
    -0.008826800108660
    0.109702658642161
    -0.045601131884100
    -0.342656715382664
    0.195766961347502
    1.024326944260331
    0.853943542705429
    0.226418982583462];

g = (-1).^(1:10).' .* h(end:-1:1);
A = zeros(10, 10);

for i = 1:10
    for j = 1:10
        x_ij = 2 * (i - 1) - (j - 1);
        if x_ij >= 0 && x_ij <= 9
            A(i, x_ij + 1) = h(j);
        end
    end
end

[V, D] = eig(A);
f = V(:, 1) / sum(V(:, 1));

m = 4;
x = 0:2^(-m):9;
phis = zeros(length(x), 1);
psis = zeros(length(x), 1);

for i = 1:length(x)
    phis(i) = phi(x(i), f);
    psis(i) = psi(x(i), f, g);
end

plot(x, phis)
hold on
plot(x, psis)
hold off

function y = phi(x, f)
    if x >= 9 || x <= 0
        y = 0;
    elseif x - ceil(x) == 0
        y = f(x + 1);
    else
        h = [0.004717427938400 
            -0.017791870101860 
            -0.008826800108660
            0.109702658642161
            -0.045601131884100
            -0.342656715382664
            0.195766961347502
            1.024326944260331
            0.853943542705429
            0.226418982583462];
        y = 0;
        for j = 1:10
            y = y + h(j) * phi(2 * x + 1 - j, f);
        end
    end
end

function y = psi(x, f, g)
    y = 0;
    for j = 1:10
        y = y + g(j) * phi(2 * x + 1 - j, f);
    end
end
