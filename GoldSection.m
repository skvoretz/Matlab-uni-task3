function res = GoldSection(func, eps, a, b, x, i)
if (i < 1) || (i > length(x))
    error('OUT OF RANGE');
end
thi = (1 + sqrt(5))/2;
x1 = x;
x2 = x;
x1(i) = b - (b-a)/thi;
x2(i) = a + (b-a)/thi;

while (b-a)/2 >= eps
    disp(func(x1));
    if func(x1) > func(x2)
        a = x1(i);
        x1(i) = x2(i);
        x2(i) = b - (x1(i)-a);
    elseif func(x1) < func(x2)
        b = x2(i);
        x2(i) = x1(i);
        x1(i) = a + (b - x2(i));
    end
end
x(i) = (a+b)/2;
res = x;
end