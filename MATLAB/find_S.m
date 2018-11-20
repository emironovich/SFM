function S = find_S(F_sym, L_1, L_2, Q_sym)
%     F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
%     syms L_1 L_2; % distortion parametrs (unknown)  

    %X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
    %    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
    %    L_2*F(3,3), L_1*L_2*F(3,3)]
    [A, X] = find_AX(F_sym, L_1, L_2, Q_sym); %equations 5-7
    disp(A * X);

    PR = A*X;
    S = sym('S', [3 2]); % coefficients matrix for equation 8

    for i = 1:3
        t = PR(i, :);
        disp(t);
        [cx, tx] = coeffs(t, [F_sym(2,3) F_sym(3,3)]);
        disp('Coeff:');
        disp(cx);
        disp('Poly:');
        disp(tx);
        S(i, :) = cx;
    end

    disp(S);
end