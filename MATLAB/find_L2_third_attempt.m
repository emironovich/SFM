function L2 = find_L2_third_attempt(R, L1)
    myR = zeros(4);
    for i = 1 : 4
        for j = 1 : 4
            myR(i, j) = polyval(squeeze(R(i, j, :)), L1);
        end
    end
    disp(det(myR));
%     kernal_basis = null(myR);
%     %i suppose that rank(R) = 3 is true
%     L2 = kernal_basis(3) / kernal_basis(4);
    
    [~,~,V]=svd(myR);
    L2 = V(3, 4) / V(4, 4);
end