function [X, Y, L1, L2, F, R, t] = generate_the_right_way()
    p = rand(3, 1);
    Sp = make_skew(p);
    t = rand(3, 1);
    R = expm(Sp);
    R = eye(3);
    
    f1 = rand(1);
    f2 = rand(1);
    K1 = eye(3);
    K1(3,3) = f1;
    K2 = eye(3);
    K2(3,3) = f2;
    
    E = make_skew(t) * R;
    F = K1' * E * K2; %really??????????????
    
    
    points_in_space = rand(3, 10);
    [X, L1] = space_to_image(points_in_space);
    for i = 1 : 10
        points_in_space(:, i) = R * points_in_space(:, i) + t; %or another way around????
    end
    [Y, L2] = space_to_image(points_in_space);
end