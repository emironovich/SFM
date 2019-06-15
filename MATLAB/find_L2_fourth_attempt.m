function L2 = find_L2_fourth_attempt(L1, R12, R13, R14, R31, R32, R33, R34, R41, R42, R43, R44)
    myR = zeros(4);
    L1mon = [L1^3; L1^2; L1; 1];
   % myR(1,1) = 0;
    myR(1,2) = R12*L1mon;
    myR(1,3) = R13*L1mon;
    myR(1,4) = R14*L1mon;
    myR(2,1) = myR(1,2);
    myR(2,2) = myR(1,3);
    myR(2,3) = myR(1,4);
   % myR(2,4) = 0;
    myR(3,1) = R31*L1mon;
    myR(3,2) = R32*L1mon;
    myR(3,3) = R33*L1mon;
    myR(3,4) = R34*L1mon;
    myR(4,1) = R41*L1mon;
    myR(4,2) = R42*L1mon;
    myR(4,3) = R43*L1mon;
    myR(4,4) = R44*L1mon;
    
%     kernal_basis = null(myR);
%     %i suppose that rank(R) = 3 is true
%     L2 = kernal_basis(3) / kernal_basis(4);
    
    
    [Q, ~] = qr(myR');
    L2 = Q(3, 4) / Q(4, 4);

%     [~,~,V]=svd(myR);
%     L2 = V(3, 4) / V(4, 4);
end