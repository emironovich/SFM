function L2_all = find_L2(E, Q_sym, Q, L_1, L_2, L1_pr)
    L2_all = zeros(0);
    first_time = true;
    for i = 1 : 3
        temp = roots(coeffs(subs(subs(E(i), Q_sym, Q), L_1, L1_pr), L_2));
        if first_time
            L2_all = temp;
            first_time = false;
        else
            L2_all = intersect(L2_all, temp);
        end
    end
end