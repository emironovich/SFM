function F = find_F(Q, L1_pr, L2_pr)
    F = ones(3); %F(3, 3) = 1;
    
    mon23 = [L2_pr; 1];
    mon33 = [1; L1_pr; L2_pr; L1_pr*L2_pr];
    S11 = Q(5,1:2)*mon23 - L1_pr*Q(6,1:2)*mon23; %equation (5)
    S12 = Q(5,3:6) * mon33 - L1_pr*Q(6, 3:6)*mon33;
    F(2, 3) = -S12/S11;

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