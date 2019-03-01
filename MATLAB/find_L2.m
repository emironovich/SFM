%THIS IS THE OUTDATED VERSION, NOT SUPPOSED TO WORK

function L2_all = find_L2(E, Q_sym, Q, L_1, L_2, L1_pr, tol)    
    L2_all = zeros(0);
    for i = 1 : 3
        temp = roots(coeffs(subs(subs(E(i), Q_sym, Q), L_1, L1_pr), L_2));
        if i == 1
            L2_all = temp;
        else
            new_L2 = zeros(0);
            for j = 1 : length(L2_all)
                for k = 1 : length(temp)
                    if L2_all(j) - temp(k) <= tol
                        new_L2(end + 1) = L2_all(j);
                        break;
                    end
                end
            end
            L2_all = new_L2;
        end
    end
end