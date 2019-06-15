%test data
tol = 1e-5;
numtests = 1;
[x, y, xx, yy, L1_th, L2_th, F_th] = generate_the_right_way();
[F_set, L1_set, L2_set, num, R] = numbers(x, y, xx, yy, tol);

%% Test 1: checking R
    myR = zeros(4);
    for i = 1 : 4
        for j = 1 : 4
            myR(i, j) = polyval(squeeze(R(i, j, :)), L1_th);
        end
    end
    mon = [L2_th^3; L2_th^2; L2_th; 1];
    RL = myR * mon;
    disp(RL);
    assert(det(myR) < tol, "The determinant is too big: %d", det(myR)); 
    assert(norm(RL) < tol);
    
%% Test 2: checking F

for i = 1 : numtests
    %[x, y, xx, yy, L1_th, L2_th, F_th] = generate_the_right_way();
    %[F_set, L1_set, L2_set, num] = numbers(x, y, xx, yy, tol);
    norm_min = 100000000000;
    F_best = zeros(3);
    L1_best = 0;
    L2_best = 0;
    for j = 1 : num
        F = squeeze(F_set(j, :, :));
        L1 = L1_set(j);
        L2 = L2_set(j);
        norm_fst = norm(F/norm(F) - F_th/norm(F_th));
        norm_snd = norm(F/norm(F) - F_th/norm(F_th));
        if (norm_fst < norm_min) || (norm_snd < norm_min)
            norm_min = min(norm_fst, norm_snd);
            F_best = F;
            L1_best = L1;
            L2_best = L2;
        end
    end
    disp(L1_best);
    disp(L2_best);
    disp(L1_th);
    disp(L2_th);
    assert(norm_min < tol);
end