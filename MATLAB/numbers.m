function numbers(CX, TX)
x = rand(1, 10);
y = rand(1, 10);
%y = ones(1, 10); todo THIS DOES NOT WORK
F_th = rand(3);
L1_th = rand(1);
X = [x; y;  L1_th * (x.^2 + y.^2)]; % colomns are coordinates in first image + distortion

xx = zeros(1, 10); %will define from equation
yy = rand(1, 10);
L2_th = rand(1);

syms t z real;

for i = 1:10
    ex = (X(:, i))' * F_th * [t; z; L2_th * (t^2 + z^2)];
    [c, cx] = coeffs(ex, t);
%     disp(c);
%     disp(cx);
    d = c(2)*c(2) - 4 * c(1) * c(3);
%     disp(d);
    [zc, zx] = coeffs(d, z);
%     disp(zc);
%     disp(zx);
    newz = (-zc(2) + (zc(2)*zc(2) - 4*zc(1)*zc(3))^(1/2)) / (2 * zc(1));
%     disp(double(newz));
%     disp(double(subs(d, z, newz)));
    newt = -c(2) / (2 * c(1));
%     disp(double(newt));
%     disp(double(subs(ex, [z t], [newz newt])));
    xx(i) = newt;
    yy(i) = newz;
    
end

Y = [xx; yy;  L2_th * (xx.^2 + yy.^2)];
% disp(Y);

% for i = 1:10
%     disp(double((X(:, i))' * F * Y(:, i)));
% end

M = find_M(x, y, xx, yy);
MG = rref(M);
disp(MG);

Q = MG(:, 11:16);
disp(Q);

S = find_S();
%[CX, TX] = find_poly(S);
disp('I am back!');
disp(TX);

Q_s = sym('q_%d_%d', [10 6]);

L1_all = roots(subs(CX, Q_s, Q)); %comples roots
%disp(L1_all);

syms L_1 L_2;

for i = 1:10
    if imag(L1_all(i)) ~= 0
        disp('Complex root L1:');
        disp(L1_all(i));
        continue;
    end
    L1 = L1_all(i);
    L2_all = roots(coeffs( subs(  subs(det(S(1:2, :)), Q_s, Q) , L_1, L1) , L_2));
    for j = 1:2
        if imag(L2_all(j)) ~= 0
           disp('Complex root L2:');
           disp(L2_all(j));
           continue;
        end
        L2 = L2_all(j);
        F = ones(3);
        F(2,3) = subs(subs(-S(1,2)/S(1,1), [L_1 L_2], [L1 L2]), Q_s, Q);
        
        X = zeros(6, 1);
        
        X(1) = L2 * F(2, 3);
        X(2) = F(2, 3);
        X(3) = F(3, 3);
        X(4) = L1 * F(3, 3);
        X(5) = L2 * F(3, 3);
        X(6) = L1 * L2 * F(3, 3);

        F(1, 1) = Q(1,:) * X;
        F(1, 2) = Q(2, :) * X;
        F(2, 1) = Q(3, :) * X;
        F(2, 2) = Q(4, :) * X;
        F(3, 1) = Q(6, :) * X;
        F(3, 2) = Q(8, :) * X;
        F(1, 3) = Q(10, :) * X;
        
        disp('Here are the results for L1, L2:');
        disp([L1 L2]);
        disp('The real L1 and L2 are:');
        disp([L1_th L2_th]);
        disp('Here is the counted F:');
        disp(F);
        disp('The real F is:');
        disp(F_th);
        disp('Here is F_th divided by obtainted F');
        disp(F_th./F);
    end    
end
end




