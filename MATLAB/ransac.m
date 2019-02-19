%executes RANSAC method for given datasets of correspondin points 2xdata_size and makes it_num
%iterations with tol tolerance

function [L1_best, L2_best, F_best] =  ransac(dataset_fst, dataset_snd, data_size, it_num, tol)
    num_best = 0;
    x = dataset_fst(1, :);
    y = dataset_fst(2, :);
    xx = dataset_snd(1, :);
    yy = dataset_snd(2, :);
    for i = 1 : it_num
        ind = randperm(data_size, 10); %ten random indecies from 1 to data_size
        [F_set, L1_set, L2_set, num] = numbers(x(ind), y(ind), xx(ind), yy(ind), tol);
        for j = 1 : num
            F = F_set(j, :, :);
            L1 = L1_set(j);
            L2 = L2_set(j);
            X = [x; y;  1 + L1 * (x.^2 + y.^2)];
            Y = [xx; yy;  1 + L2 * (xx.^2 + yy.^2)];
            curr_num = 0;
            for k = 1 : data_size
                if((X(:, i))' * F * Y(:, i) <= tol)
                    curr_num = curr_num + 1;
                end
            end
            if(curr_num > num_best)
                num_best = curr_num;
                F_best = F;
                L1_best = L1;
                L2_best = L2;
            end
        end
    end
    fprintf('Current model satisfies %d out of %d pairs of points.\n', num_best, data_size);
    fprintf('That is %d%%\n', (num_best / data_size) * 100);
end