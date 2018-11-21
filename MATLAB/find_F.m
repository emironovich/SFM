function F = find_F(S, Q_sym, Q, L_1, L_2, L1_pr, L2_pr)
    F = ones(3); %F(3, 3) = 1;
    F(2, 3) = subs(subs(-S(1,2)/S(1,1), [L_1 L_2], [L1_pr L2_pr]), Q_sym, Q);

    X = zeros(6, 1);

    X(1) = L2_pr * F(2, 3);
    X(2) = F(2, 3);
    X(3) = F(3, 3);
    X(4) = L1_pr * F(3, 3);
    X(5) = L2_pr * F(3, 3);
    X(6) = L1_pr * L2_pr * F(3, 3);

    F(1, 1) = -Q(1,:) * X;
    F(1, 2) = -Q(2, :) * X;
    F(2, 1) = -Q(3, :) * X;
    F(2, 2) = -Q(4, :) * X;
    F(3, 1) = -Q(6, :) * X;
    F(3, 2) = -Q(8, :) * X;
    F(1, 3) = -Q(10, :) * X;
end