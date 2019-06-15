function poly = find_det_R(R12, R13, R14, R31, R32, R33, R34, R41, R42, R43, R44) %R(i,j,:) -- poly coeffs
    poly = zeros(1, 13);
    % 	R21 = R12;
    % 	R22 = R13;
    % 	R23 = R14;

    
    %expansion along the first row
    %r11 = 0
    %r12
        %expansion along the first row of the complement
        det14 = poly_det22(R31, R34, R41, R44);
        poly = poly + (-1)*conv(R12,(conv(R12, poly_det22(R33, R34, R43, R44)) - conv(R14, det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (+1)*conv(R13, (conv(R12, poly_det22(R32, R34, R42, R44)) - conv(R13, det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (-1)*conv(R14, (conv(R12, poly_det22(R32, R33, R42, R43)) - conv(R13, poly_det22(R31, R33, R41, R43)) + conv(R14, poly_det22(R31, R32, R41, R42))));
end