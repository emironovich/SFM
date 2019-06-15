syms x;
M = sym('m_%d_%d',4);
for i = 1 : 4
    for j = 1 : 4
        M(i,j) = (ceil(rand()*10)*x^3 + ceil(rand()*10)*x^2 + ceil(rand()*10)*x +(ceil(rand()*10)));
    end
end



R = zeros(4,4,4);
for i = 1 : 4
    for j = 1 : 4
        R(i, j, :) = coeffs(M(i, j), 'All');
    end
end


M(1,1) = 0;
M(2,4) = 0;
% M(2,2) = 0;
% M(1,3) = 0;
% M(2,3) = 0;
% M(1,4) = 0;


R(1,1,:) = [0, 0, 0, 0];
R(2,4,:) = [0, 0, 0, 0];
% R(2,2,:) = [0, 0];
% R(1,3,:) = [0, 0];
% R(2,3,:) = [0, 0];
% R(1,4,:) = [0, 0];
disp(M);
disp(det(M));
disp(find_det_R(R))