%test data
[X, Y, L1, L2, F, R, t] = generate_the_right_way();

tol = 1e-8;

 %% Test 1: equality check
 
 for i = 1 : 10
     disp((X(:, i))' * F * Y(:, i));
     assert(abs((X(:, i))' * F * Y(:, i)) <= tol, 'The test data does not satisfy the first equation')
 end