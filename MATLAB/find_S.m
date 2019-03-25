function S = find_S(L_1, L_2, Q)
    %todo CHECK
    S = sym('f_%d_%d',[3 2]);
    mon23 = [L_2; 1];
    mon33 = [1; L_1; L_2; L_1*L_2];
    
    S(1, 1) = Q(5,1:2)*mon23 - L_1*Q(6,1:2)*mon23; %equation (5)
    S(1, 2) = Q(5,3:6) * mon33 - L_1*Q(6, 3:6)*mon33;
    
    S(2, 1) = Q(7,1:2)*mon23 - L_1*Q(8,1:2)*mon23; %equation (6)
    S(2, 2) = Q(7,3:6) * mon33 - L_1*Q(8, 3:6)*mon33;
    
    S(3, 1) = Q(9,1:2)*mon23 - L_2*Q(10,1:2)*mon23; %equation (6)
    S(3, 2) = Q(9,3:6) * mon33 - L_2*Q(10, 3:6)*mon33;
    
    
end