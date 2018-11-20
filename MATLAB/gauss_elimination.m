function M =  gauss_elimination(M) 
for i = 1:10
    t = M(i, i);
    if t == 0
        continue;
    end
    for j = i : 16 
        M(i, j) = M(i, j) / t;
    end
    for j = 1:10
        if j == i
            continue;
        end
        t = M(j, i);
        for k = i : 16
            M(j, k) = M(j, k) / t - M(i, k);
        end
    end
end
end