function poly = find_det_R(R) %R(i,j,:) -- poly coeffs
    poly = zeros(13, 1);
    %expansion along the first row
    %r11 = 0
    %r12
        %expansion along the first row of the complement
        det14 = poly_det22([R(3,1,:), R(3,4,:); R(4,1,:) R(4,4,:)]);
        poly = poly + (-1)*conv(reshape(R(1,2,:), [4, 1]),(conv(reshape(R(2,1,:), [4, 1]),poly_det22(R(3:4, 3:4,:))) - conv(reshape(R(2,3,:), [4, 1]), det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (+1)*conv(reshape(R(1,3,:), [4, 1]), (conv(reshape(R(2,1,:), [4, 1]), poly_det22([R(3,2,:), R(3,4,:); R(4,2,:) R(4,4,:)])) - conv(reshape(R(2,2,:), [4, 1]), det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (-1)*conv(reshape(R(1,4,:), [4, 1]), (conv(reshape(R(2,1,:), [4, 1]), poly_det22(R(3:4, 2:3,:))) - conv(reshape(R(2,2,:), [4, 1]), poly_det22([R(3,1,:), R(3,3,:); R(4,1,:) R(4,3,:)])) + conv(reshape(R(2,3,:), [4, 1]), poly_det22(R(3:4, 1:2,:)))));
end