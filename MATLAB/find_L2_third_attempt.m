function L2 = find_L2_third_attempt(R, Q_sym, Q, L_1, L1_pr)
    myR = double(subs(subs(R, Q_sym, Q), L_1, L1_pr));
    kernal_basis = null(myR);
    %i suppose that rank(R) = 3 is true
    L2 = kernal_basis(3) / kernal_basis(4);
end