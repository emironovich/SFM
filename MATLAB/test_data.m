%test data
[x, y, xx, yy, L1, L2, F, R, t] = generate_the_right_way();

tol = 1e-8;

 %% Test 1: equality check for first coordinates
 
X = [x; y;  1 + L1 * (x.^2 + y.^2)];
Y = [xx; yy;  1 + L2 * (xx.^2 + yy.^2)];
 for i = 1 : 10
     disp((X(:, i))' * F * Y(:, i));
     assert(abs((X(:, i))' * F * Y(:, i)) <= tol, 'The test data does not satisfy the first equation')
 end

