%this is the FL1L2 solver

function [F_set, L1_set, L2_set, num] = numbers(x, y, xx, yy, tol)
    F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
    syms L_1 L_2; % distortion parametrs (unknown)  

    %X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
    %    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
    %    L_2*F(3,3), L_1*L_2*F(3,3)]
    Q_sym = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination

    %[x, y, xx, yy, L1_th, L2_th, F_th] = generate_the_right_way();

    M = find_M(x, y, xx, yy);
    MG = rref(M);
    disp(MG);

    Q = MG(:, 11:16);
    disp(Q);

    S = find_S(F_sym, L_1, L_2, Q_sym);
    [CX, TX, R] = find_poly(S, L_1, L_2);
    disp('I am back!');
    disp(TX);

    L1_all = roots(subs(CX, Q_sym, Q)); %comples roots
    disp('THESE ARE L1');
    disp(L1_all);
    L1_new = zeros(10);
    num = 0;
    for i = 1 : length(L1_all)
        if abs(imag(L1_all(i))) < tol
            L1_new(i) = real(L1_all(i));
            num = num + 1;
        end
    end
    L1_new = L1_new(1:num);
    L1_all = L1_new;

    syms L_1 L_2;
    
    F_set = zeros(num, 3, 3);
    L1_set = zeros(1, num);
    L2_set = zeros(1, num);
    
    for i = 1:num
        L1 = L1_all(i);
        L2_all = find_L2_another_way(R, Q_sym, Q, L_1, L1, tol);
        L2 = double(L2_all(1)); %there should be only one value, but just in case smth is wrong   
        F = find_F(S, Q_sym, Q, L_1, L_2, L1, L2);
        disp('Here are the results for L1, L2:');
        disp([L1 L2]);
    %     disp('The real L1 and L2 are:');
    %     disp([L1_th L2_th]);
        disp('Here is the counted F:');
        disp(F);
    %     disp('The real F is:');
    %     disp(F_th);
    %     disp('Here is F_th divided by obtainted F');
    %     disp(F_th./F);  
        F_set(i, :, :) = F;
        L1_set(i) = L1;
        L2_set(i) = L2;

    end

end




