%this is the script that uses written solver for generated data

N = 20;
tol_for_ans = 10e-12;
num_wrong = 0;
diff_wrong = zeros(N);
for k = 1 : N
    [x, y, xx, yy, L1, L2, F, R, t] = generate_the_right_way();
    tol = 1e-8;
    [F_set, L1_set, L2_set, num] = numbers(x, y, xx, yy, tol);

    min_diff = 1e10;
    min_diff_ind = 1;
    for i = 1 : num
        F_curr = squeeze(F_set(i, :, :));
        L1_curr = L1_set(i);
        L2_curr = L2_set(i);
        diff_fst = norm(F/norm(F, 'fro') - F_curr/norm(F_curr, 'fro'), 'fro');
        diff_snd = norm(F/norm(F, 'fro') + F_curr/norm(F_curr, 'fro'), 'fro');
        diff = min([diff_fst, diff_snd]);
        disp('----------------------------------------');
        disp('The difference between matricies is:');
        disp(diff);
        disp('The difference between L1 is:');
        disp(abs(L1 - L1_curr));
        disp('The difference between L2 is:');
        disp(abs(L2 - L2_curr));
        curr_diff = norm([diff, abs(L1 - L1_curr), abs(L2 - L2_curr)]);
        if curr_diff < min_diff
            min_diff = curr_diff;
            min_diff_ind = i;
        end
    end

    disp('The minimal differense value set is')
    F_curr = squeeze(F_set(min_diff_ind, :, :));
    L1_curr = L1_set(min_diff_ind);
    L2_curr = L2_set(min_diff_ind);
    diff_fst = norm(F/norm(F, 'fro') - F_curr/norm(F_curr, 'fro'), 'fro');
    diff_snd = norm(F/norm(F, 'fro') + F_curr/norm(F_curr, 'fro'), 'fro');
    diff = min([diff_fst, diff_snd]);
    disp('The difference between matricies is:');
    disp(diff);
    disp('The difference between L1 is:');
    disp(abs(L1 - L1_curr));
    disp('The difference between L2 is:');
    disp(abs(L2 - L2_curr));
    curr_diff = norm([diff, abs(L1 - L1_curr), abs(L2 - L2_curr)]);
    if curr_diff > tol_for_ans
        num_wrong = num_wrong + 1;
        diff_wrong(num_wrong) = curr_diff;
    end
end
diff_wrong = diff_wrong(1 : num_wrong);
disp('The number of worst differences is:');
disp(num_wrong);
disp('Here are bad results');
disp(diff_wrong);