function dy = ft7_1(t, y)
dy = zeros(2, 1);
dy(1) = y(1)^3 - y(2);
dy(2) = y(1) + y(2)^3;
end