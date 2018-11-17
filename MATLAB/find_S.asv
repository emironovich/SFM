function S = find_S()
    F = sym('f_%d_%d',3); % fumdamental matrix (unknown)
    syms L_1 L_2; % distortion parametrs (unknown)  

    %X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
    %    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
    %    L_2*F(3,3), L_1*L_2*F(3,3)]
    I = sym('I', [10 10]); % identity matrix
    Q = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination

    for i = 1:10
        for j = 1:10 
            I(i,j) = '0';
            if(i == j) 
                I(i,j) = '1';
            end
        end
    end

    MG = [I Q]; % matrix M after G-J elimination

    disp(MG);
    X = [L_2*F(2,3); F(2,3); F(3,3); L_1*F(3,3);  L_2*F(3,3); L_1*L_2*F(3,3)]; % polynomials for equations 5-7

    disp(X);

    A = [-L_1*Q(6,:) + Q(5,:); -L_1*Q(8,:) + Q(7,:); -L_2*Q(10,:) + Q(9,:)]; % coefficients matrix for equations 5-7

    disp(A * X);

    PR = A*X;
    S = sym('S', [3 2]); % coefficients matrix for equation 8

    for i = 1:3
        t = PR(i, :);
        disp(t);
        [cx, tx] = coeffs(t, [F(2,3) F(3,3)]);
        disp('Coeff:');
        disp(cx);
        disp('Poly:');
        disp(tx);
        S(i, :) = cx;
    end

    disp(S);
end