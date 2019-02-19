%this function generates two sets of corresponsing points, two distortion
%parameters and fundamental matrix by generating points in space, two camera models and 
%random rotation and translation between them

function [x, y, xx, yy, L1, L2, F, R, t] = generate_the_right_way()
    r_vector = rand(3, 1); %хитрая штука
    r_vector_skew = make_skew(r_vector);
    t = rand(3, 1); %translation
    R = expm(r_vector_skew); %rotation
    %R = eye(3);
    
    f1 = rand(1); %focal distance for the first camera
    f2 = rand(1); %focal distance for the second camera
    K1 = eye(3); %calibration matricies
    K1(3,3) = f1;
    K2 = eye(3);
    K2(3,3) = f2;
    
    E = make_skew(t) * R; %essential matrix
    F = K1' * E * K2; %fundamental matrix
    
    
    points_in_space = rand(3, 10);
    [L1, x, y] = space_to_image(points_in_space, f1);
    for i = 1 : 10
        points_in_space(:, i) = R \ (points_in_space(:, i) - t); %actually inv(R) * (...), only faster and more accurate
    end
    [L2, xx, yy] = space_to_image(points_in_space, f2);
end