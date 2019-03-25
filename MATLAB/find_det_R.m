function poly = find_det_R(R) %R(i,j,:) -- poly coeffs
    poly = zeros(13, 1);
    %expansion along the first row
    %r11 = 0
    %r12
        %expansion along the first row of the complement
        det14 = poly_det22([R(3,1,:), R(3,4,:); R(4,1,:) R(4,4,:)]);
        poly = poly + (-1)*conv(squeeze(R(1,2,:)),(conv(squeeze(R(2,1,:)),poly_det22(R(3:4, 3:4,:))) - conv(squeeze(R(2,3,:)), det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (+1)*conv(squeeze(R(1,3,:)), (conv(squeeze(R(2,1,:)), poly_det22([R(3,2,:), R(3,4,:); R(4,2,:) R(4,4,:)])) - conv(squeeze(R(2,2,:)), det14)));
    %r13
        %expansion along the first row of the complement
        poly = poly + (-1)*conv(squeeze(R(1,4,:)), (conv(squeeze(R(2,1,:)), poly_det22(R(3:4, 2:3,:))) - conv(squeeze(R(2,2,:)), poly_det22([R(3,1,:), R(3,3,:); R(4,1,:) R(4,3,:)])) + conv(squeeze(R(2,3,:)), poly_det22(R(3:4, 1:2,:)))));
end