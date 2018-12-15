function [points_in_image, L] = space_to_image(points_in_space)
    L = -rand(1);
    points_in_image = zeros(3, 10);
    for i = 1 : 10
        %(u, v, 1 + L*(u^2 + v^2)) = a * (x, y, z)
        x = points_in_space(1, i);
        y = points_in_space(2, i);
        z = points_in_space(3, i);
        %r = norm([u, v])
        %a = r / nxy;
        %1 + a*r^2 = (r / nxy) * z
        nxy = norm([x y]);
        r = z/(2*L*nxy) - ((z^2/(nxy^2) - 4*L)^(1/2))/(2*L);
        a = r / nxy;
        u = a * x;
        v = a * y;
        points_in_image(1, i) = u;
        points_in_image(2, i) = v;
        points_in_image(3, i) = 1 + L*(u^2 + v^2);        
    end
end