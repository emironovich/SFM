%test data
[x, y, xx, yy, L1_th, L2_th, F_th] = generate_test_data();

%symbolic variables
F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
syms L_1 L_2;
Q_sym = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination

%middle results
M = find_M(x, y, xx, yy);

MG = rref(M);
Q_th = MG(:, 11:16);
S = find_S(F_sym, L_1, L_2, Q_sym);

%preconditions
X = [x; y;  1 + L1_th * (x.^2 + y.^2)];
Y = [xx; yy;  1 + L2_th * (xx.^2 + yy.^2)];

tol = 1e-10;


 for i = 1:10
    assert((X(:, i))' * F_th * Y(:, i) <= tol, 'The test data does not satisfy the first equation')
 end
 
 %% Test 1: eq3 checking M
monomials = [F_th(1,1); F_th(1,2); F_th(2,1); F_th(2,2); L1_th * F_th(3,1); F_th(3,1); L1_th*F_th(3,2); F_th(3,2); L2_th*F_th(1,3); F_th(1,3); L2_th*F_th(2,3); F_th(2,3); F_th(3,3); L1_th*F_th(3,3); L2_th*F_th(3,3); L1_th*L2_th*F_th(3,3)];
%disp(M*monomials);
assert(max(M * monomials) <= tol)
assert(det(M(:, 1:10)) ~= 0 , 'The Gaussian elimination will not work')

%% Test 2: eq5 - eq6 checking Q
monomials = [F_th(1,1); F_th(1,2); F_th(2,1); F_th(2,2); L1_th * F_th(3,1); F_th(3,1); L1_th*F_th(3,2); F_th(3,2); L2_th*F_th(1,3); F_th(1,3); L2_th*F_th(2,3); F_th(2,3); F_th(3,3); L1_th*F_th(3,3); L2_th*F_th(3,3); L1_th*L2_th*F_th(3,3)];
disp(norm(MG * monomials) <= tol);
monomials_fst = [F_th(1,1); F_th(1,2); F_th(2,1); F_th(2,2); L1_th * F_th(3,1); F_th(3,1); L1_th*F_th(3,2); F_th(3,2); L2_th*F_th(1,3); F_th(1,3)];
monomials_snd = [L2_th*F_th(2,3); F_th(2,3); F_th(3,3); L1_th*F_th(3,3); L2_th*F_th(3,3); L1_th*L2_th*F_th(3,3)];
assert(max(Q_th * monomials_snd + monomials_fst) <= tol)
[A, X] = find_AX(F_sym, L_1, L_2, Q_sym);
A_sub = subs(subs(A, [L_1, L_2], [L1_th, L2_th]), Q_sym, Q_th);

X_sub = subs(X, [F_sym(2,3) F_sym(3,3) L_1 L_2], [F_th(2,3) F_th(3,3) L1_th L2_th]);
assert(norm(double(A_sub*X_sub), 1) <= tol)


%% Test 3: eq8 checking S
S_sub = subs(subs(S, [L_1 L_2], [L1_th L2_th]), Q_sym, Q_th);
monomials = [F_th(2, 3); F_th(3, 3)];
assert(norm(double(S_sub * monomials), 1) <= tol)

%% Test 4: eq9 - eq11 checking E
E = find_E(S, L_2);
E_sub = subs(subs(E, [L_1 L_2], [L1_th L2_th]), Q_sym, Q_th);
assert(norm(double(E_sub), 1) <= tol)

%% Test 5: eq13
R = find_R(S, L_2);
R_sub = subs(subs(R, [L_1 L_2], [L1_th L2_th]), Q_sym, Q_th);
mon = [L2_th ^ 3; L2_th ^ 2; L2_th; 1];
assert(norm(double(R_sub * mon), 1) <= tol);

%% Test 6: checking L2
[CX, TX] = find_poly(S, L_1, L_2);
disp('I am back!');
disp(TX);

L1_all = roots(subs(CX, Q_sym, Q_th)); %comples roots
E = find_E(S, L_2);
L2_all = find_L2(E, Q_sym, Q_th, L_1, L_2, L1_pr);
S_subq = subs(S, Q_sym, Q_th);
for i = 1 : 10
    if isempty(L2_all)
        disp('NO ROOTS FOR L2');
    end
    for j = 1 : length(L2_all)
        L1_pr = L1_all(i);
        L2_pr = L2_all(j);
        S_sub = subs(S_subq, [L_1 L_2], [L1_pr L2_pr]);
        disp('S_sub');
        disp(S_sub);
        assert(abs(double(S_sub(1,1) / S_sub(1,2)) - double(S_sub(2,1) / S_sub(2,2))) <= tol)
        assert(abs(double(S_sub(1,1) / S_sub(1,2)) - double(S_sub(3,1) / S_sub(3,2))) <= tol)
        assert(abs(double(S_sub(3,1) / S_sub(3,2)) - double(S_sub(2,1) / S_sub(2,2))) <= tol)
    end
end

%% Test 7: checking F
[CX, TX] = find_poly(S, L_1, L_2);
disp('I am back!');
disp(TX);

L1_all = roots(subs(CX, Q_sym, Q_th)); %comples roots
for i = 1:10
    L1_pr = L1_all(i);
    L2_all = roots(coeffs( subs(  subs(det(S(1:2, :)), Q_sym, Q_th) , L_1, L1_pr) , L_2));
    for j = 1:2
        L2_pr = L2_all(j);
        F_pr = find_F(S, Q_sym, Q_th, L_1, L_2, L1_pr, L2_pr);
        X = [x; y;  1 + L1_pr * (x.^2 + y.^2)];
        Y = [xx; yy;  1 + L2_pr * (xx.^2 + yy.^2)];
        for k = 1:10
            disp(double((X(:, k))' * F_th * Y(:, k)));
            assert(double(abs((X(:, k))' * F_th * Y(:, k))) <= tol)
        end
    end
end


        







 
 
 
 
 
 
 
 
