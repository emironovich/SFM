function P = poly_det22(M)
    P = conv(squeeze(M(1,1,:)), squeeze(M(2,2,:))) - conv(squeeze(M(1,2,:)), squeeze(M(2,1,:)));
end