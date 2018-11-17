F = sym('f_%d_%d',3); % fumdamental matrix (unknown)
x = sym('x_%d', [1 10]); % first image coordinates (known)
y = sym('y_%d', [1 10]);
%x = 100.*rand(10,1);
xx = sym('xx_%d', [1 10]); % second imaage coordinates (known)
yy = sym('yy_%d', [1 10]);

syms L_1 L_2; % distortion parametrs (unknown)  

X_1 = sym('X', [10 3]); % coordinates not corrupted by radial distorton
X_2 = sym('X', [10 3]);
for i = 1:10
    X_1(i, :) = [x(i) y(i) 1 + L_1 *(x(i)^2 + y(i)^2)];
    X_2(i, :) = [xx(i) yy(i) 1 + L_2 *(xx(i)^2 + yy(i)^2)];
end
disp (X_2);
polys = [F(1, :) F(2,:) F(3,:) L_1 L_2]; % unknown monomials
X = sym('X', [16 1]);
% X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
%     F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
%     L_2*F(3,3), L_1*L_2*F(3,3)];

M = sym('M', [10 16]); % coefficient matrix for ten equations and sixteen monomials 

for i = 1:10
    t = X_1(i, :) * F * (X_2(i, :)).';
    disp(t);
    [cx, tx] = coeffs(t, polys);
    disp('Coeff:');
    disp(cx);
    disp('Poly:');
    disp(tx);
    M(i, :) = cx;
    X = tx.';
end
disp(M);
disp(X.');

% for i = 1:10
%     M(i,:) = M(i,:) / M(i,i);
%     for j = 1:10
%         if(i == j) 
%             continue;
%         end
%         M(j,:) = M(j,:) / M(j,i);
%         M(j,:) = M(j,:) - M(i,:);
%     end
% end

disp(M);
%NEED TO CHANGE ORDER!!!!!!!!!!

%X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
%    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
%    L_2*F(3,3), L_1*L_2*F(3,3)]




