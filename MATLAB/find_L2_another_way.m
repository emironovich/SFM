function L2_all = find_L2_another_way(R, Q_sym, Q, L_1, L1_pr, tol)
    L2_all = zeros(0);
    for i = 1 : 4
        temp = double(roots(subs(subs(R(i, :), Q_sym, Q), L_1, L1_pr)));
        %disp(temp);
        if i == 1
            L2_all = temp;
        else
            new_L2 = zeros(0);
            for j = 1 : length(L2_all)
                for k = 1 : length(temp)
                    curr = temp(k);
                    if(abs(imag(curr)) < tol)
                        curr = real(curr);
                    end
                    if abs(L2_all(j) - curr) <= tol
                        new_L2(end + 1) = L2_all(j);
                        break;
                    end
                end
            end
%             disp('prev_L2');
%             disp(L2_all);
%             disp('new_L2');
%             disp(new_L2);
            L2_all = new_L2;
            
        end
    end
end