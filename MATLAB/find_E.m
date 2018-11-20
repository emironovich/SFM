function E = find_E(S, L_2)
    E = sym('E', [4 1]);
    E(1) = det(S(1:2, :)); % = 0 equation 9
    E(2) = det(S(2:3, :)); % = 0 equation 11
    E(3) = det([S(1,:); S(3,:)]); % = 0 equation 8
    E(4) = L_2 * det(S(1:2, :));
end