%script that finds symbolic R and outputs it in the file

F_sym = sym('f_%d_%d',3); % fumdamental matrix (unknown)
syms L_1 L_2; % distortion parametrs (unknown)  
Q_sym = sym('q_%d_%d', [10 6]); % leftovers afret G-J elimination
S = find_S(F_sym, L_1, L_2, Q_sym);
R = find_R(S, L_2);
disp(R);
disp(polynomialDegree(R, L_1));
fileID = fopen('R.txt','wt');
for i = 1 : 4
    for j = 1 : 4
        disp(coeffs(R(i, j), L_1));
        if polynomialDegree(R(i, j), L_1) == 0
            fprintf(fileID,"0\n");
        else
            fprintf(fileID, '%s\n', coeffs(R(i, j), L_1));
        end
        fprintf(fileID, "$\n");
    end
end

fclose(fileID);