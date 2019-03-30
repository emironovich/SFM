function L2 = find_L2_fourth_attempt(R, L1)
    myR = zeros(4);
    L12 = L1*L1;
    L13 = L1*L12;
    for i = 1 : 4
        for j = 1 : 4
            myR(i, j) = R(i, j, 1) * L13 + R(i, j, 2) * L12 + R(i, j, 3) * L1 + R(i, j, 4);
        end
    end
%     kernal_basis = null(myR);
%     %i suppose that rank(R) = 3 is true
%     L2 = kernal_basis(3) / kernal_basis(4);
    
    [~,~,V]=svd(myR);
    L2 = V(3, 4) / V(4, 4);
end