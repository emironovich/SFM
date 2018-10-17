F = sym('f_%d_%d',3); % fumdamental matrix (unknown)
x = sym('x_%d', [1 10]); % first image coordinates (known)
y = sym('y_%d', [1 10]);
%x = 100.*rand(10,1);
xx = sym('xx_%d', [1 10]); % second imaage coordinates (known)
yy = sym('yy_%d', [1 10]);

syms L_1 L_2; % distortion parametrs (unknown)  

%X = [F(1,1), F(1,2), F(2,1), F(2,2), L_1 * F(3,1), F(3,1), L_1*F(3,2),
%    F(3,2), L_2*F(1,3), F(1,3), L_2*F(2,3), F(2,3), F(3,3), L_1*F(3,3),
%    L_2*F(3,3), L_1*L_2*F(3,3)]
I = sym('I', [10 10]); % identity matrix
Q = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination

for i = 1:10
    for j = 1:10 
        I(i,j) = '0';
        if(i == j) 
            I(i,j) = '1';
        end
    end
end

MG = [I Q]; % matrix M after G-J elimination

disp(MG);
X = [L_2*F(2,3); F(2,3); F(3,3); L_1*F(3,3);  L_2*F(3,3); L_1*L_2*F(3,3)]; % polynomials for equations 5-7

disp(X);

A = [-L_1*Q(6,:) + Q(5,:); -L_1*Q(8,:) + Q(7,:); -L_2*Q(10,:) + Q(9,:)]; % coefficients matrix for equations 5-7

disp(A * X);

PR = A*X;
S = sym('S', [3 2]); % coefficients matrix for equation 8

for i = 1:3
    t = PR(i, :);
    disp(t);
    [cx, tx] = coeffs(t, [F(2,3) F(3,3)]);
    disp('Coeff:');
    disp(cx);
    disp('Poly:');
    disp(tx);
    S(i, :) = cx;
end

disp(S);

D = det(S(1:2, :));
disp(D);
disp(det(S(1:2, :)));
disp(det(S(2:3, :)));
disp(det([S(1,:); S(3,:)]));

E = sym('E', [4 1]);
E(1) = det(S(1:2, :)); % = 0 equation 9
E(2) = det(S(2:3, :)); % = 0 equation 11
E(3) = det([S(1,:); S(3,:)]); % = 0 equation 8
E(4) = L_2 * det(S(1:2, :));

R = sym('R', [4 4]); % coefficients matrix for equation 13

for i = 1:4
    t = E(i);
    disp(t);
    [cx, tx] = coeffs(t, L_2);
    if(tx(1) ~= L_2^3)
        cx = [0 cx];
    end
    if(tx(end) ~= 1)
        cx = [cx 0];
    end
    disp('Coeff:');
    disp(cx);
    disp('Poly:');
    disp(tx);
    R(i, :) = cx;
end

%disp(R);
%disp(coeffs(det(R), L_1));
[CX, TX] = coeffs(det(R), L_1);

%NOW I AM GOING TO PRINT ALL THAT I NEED!!

%FIRSTLY ALL COEFFICIENT OF THE POLYNOMIAL

poly = 'poly';
txt = '.txt';

for i = 1:10
    fileID = fopen([poly '0'+i-1 txt],'wt');
    fprintf(fileID, '%s \n', CX(i));
    fclose(fileID);
end

fileID = fopen([poly '10' txt],'wt');
fprintf(fileID, '%s \n', CX(i));
fclose(fileID);

%NOW THE COEFFCIENTS OF THE QUADRIC POLYNOMIAL FOR FINDING L_2

disp(det(S(1:2, :))); %for finding L_2
[cl, tl] = coeffs(det(S(1:2, :)), L_2);
disp(cl);
disp(tl); %[ L_2^2, L_2, 1]

fileID = fopen('coeffs_for_L2.txt','wt');

for i = 1:3
    fprintf(fileID, 'L2[%d] = ', i - 1);
    if(i ~= 3)
        fprintf(fileID, '%s;\n', cl(i));
    else
        fprintf(fileID, '%s\n', cl(i));
    end
    
end

fclose(fileID);

%NOW THE EXPRESSION FOR FINDING F_2_3

fileID = fopen('coeffs_for_F_2_3.txt','wt');
fprintf(fileID, 'F[2][3] = %s', -S(1,2)/S(1,1));
fclose(fileID);



