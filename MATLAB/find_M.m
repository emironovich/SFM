function M = find_M(x, y, xx, yy)
    M = zeros(10, 16);
    for i = 1:10 % THIS IS PROBABLY OK
		M(i, 1) = x(i) * xx(i);  %  f_1_1, 
		M(i, 2) = x(i) * yy(i); % f_1_2, 
		M(i, 3) = xx(i) * y(i); % f_2_1; 
		M(i, 4) = y(i) * yy(i); % f_2_2; 	
		M(i, 5) = xx(i) * (x(i)^2 + y(i)^2); %  L_1*f_3_1; 
		M(i, 6) = xx(i); % f_3_1;
		M(i, 7) = yy(i) * (x(i)^2 + y(i)^2); %  L_1*f_3_2; 
		M(i, 8) = yy(i); % f_3_2;
		M(i, 9) = x(i) * (xx(i)^2 + yy(i)^2); % L_2*f_1_3; 
		M(i, 10) = x(i); % f_1_3; 
		M(i, 11) = y(i) * (xx(i)^2 + yy(i)^2); % L_2*f_2_3; 
		M(i, 12) = y(i); % f_2_3;
		M(i, 13) = 1; % f_3_3
		M(i, 14) = x(i)^2 + y(i)^2;  % L_1*f_3_3;
		M(i, 15) = xx(i)^2 + yy(i)^2;  %  L_2*f_3_3; 
		M(i, 16) = (x(i)^2 + y(i)^2)*(xx(i)^2 + yy(i)^2); %  L_1*L_2*f_3_3; 
    end
end