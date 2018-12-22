function [CX, TX, R] = find_poly(S, L_1, L_2)
    R = find_R(S, L_2);
    [CX, TX] = coeffs(det(R), L_1);
    disp(TX);

end