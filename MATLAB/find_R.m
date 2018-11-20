function R = find_R(S, L_2)
    E = find_E(S, L_2);
    R = sym('R', [4 4]); % coefficients matrix for equation 13

    for i = 1:4
        t = E(i);
%         disp(t);
        [cx, tx] = coeffs(t, L_2);
        if(tx(1) ~= L_2^3)
            cx = [0 cx];
        end
        if(tx(end) ~= 1)
            cx = [cx 0];
        end
%         disp('Coeff:');
%         disp(cx);
%         disp('Poly:');
%         disp(tx);
        R(i, :) = cx;
    end
end