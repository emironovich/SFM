function P = poly_det22(M)
    P = conv(reshape(M(1,1,:), [4, 1]), reshape(M(2,2,:), [4, 1])) - conv(reshape(M(1,2,:), [4, 1]), reshape(M(2,1,:), [4, 1]));
end