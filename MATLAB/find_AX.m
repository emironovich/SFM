function [A, X] = find_AX(F_sym, L_1, L_2, Q_sym)
%     F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
%     syms L_1 L_2; % distortion parametrs (unknown)  
% 
%     %X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
%     %    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
%     %    L_2*F(3,3), L_1*L_2*F(3,3)]
%     Q_sym = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination
    X = [L_2*F_sym(2,3); F_sym(2,3); F_sym(3,3); L_1*F_sym(3,3);  L_2*F_sym(3,3); L_1*L_2*F_sym(3,3)]; % polynomials for equations 5-7
    A = [-L_1*Q_sym(6,:) + Q_sym(5,:); -L_1*Q_sym(8,:) + Q_sym(7,:); -L_2*Q_sym(10,:) + Q_sym(9,:)]; % coefficients matrix for equations 5-7
end