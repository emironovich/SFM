%this is the script that uses RANSAC method for FL1L2 solver on generated
%data

data_size = 1000;
tol = 10e-14;
[x, y, xx, yy, L1, L2, F, R, t] = generate_the_right_way(data_size);

[L1_best, L2_best, F_best] =  ransac(x, y, xx, yy, data_size, 2, tol);