%this is the FL1L2 solver

function [F_set, L1_set, L2_set, num] = numbers(x, y, xx, yy, tol)
    %F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
    %syms L_1 L_2; % distortion parametrs (unknown)  

    %X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
    %    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
    %    L_2*F(3,3), L_1*L_2*F(3,3)]
    %Q_sym = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination

    %[x, y, xx, yy, L1_th, L2_th, F_th] = generate_the_right_way();

    M = find_M(x, y, xx, yy);
    Q = M(:, 1:10)\M(:, 11:16);
    %disp(Q);

    [R12, R13, R14, R31, R32, R33, R34, R41, R42, R43, R44] = find_R_num(Q);
    poly = find_det_R(R12, R13, R14, R31, R32, R33, R34, R41, R42, R43, R44);
    L1_all = roots(poly); %complex roots
%     disp('THESE ARE L1');
%     disp(L1_all);
    L1_new = zeros(10);
    num = 0;
    for i = 1 : 10
        if abs(imag(L1_all(i))) < tol && real(L1_all(i)) >= -10 && real(L1_all(i)) <= 2
            num = num + 1;
            L1_new(num) = real(L1_all(i));
        end
    end
    %L1_new = L1_new(1:num);
    %L1_all = L1_new;
    
    F_set = zeros(num, 3, 3);
    L1_set = zeros(1, num);
    L2_set = zeros(1, num);
    
    for i = 1:num
        L1 = L1_new(i);
        L2 = find_L2_fourth_attempt(L1, R12, R13, R14, R31, R32, R33, R34, R41, R42, R43, R44);
        F = find_F(Q, L1, L2);
%         disp('Here are the results for L1, L2:');
%         disp([L1 L2]);
%         disp('Here is the counted F:');
%         disp(F);
        F_set(i, :, :) = F; %probably shoud change it to F(:,:,i) since that makes more sense
        L1_set(i) = L1;
        L2_set(i) = L2;

    end

end




