function P = poly_det22(M11, M12, M21, M22)
    P = conv(M11, M22) - conv(M12, M21);
end