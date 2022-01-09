function res = CoorDescent(varargin)
n = nargin;
if n <= 2
    error('NO DERIVATIVES');
end

x0 = varargin{2};
f = varargin{1};

if n ~= length(x0) + 2
   error('NOT ENOUGH PARAMETRS');
end

k_max = 100; % чтобы не зацикливаться
eps = 0.000001; % точность
e_gold = 0.01; % точность для золотого сечения
a = 1;
b = 10;
for k = 1:k_max
    x0_prev = x0;
    for i = 3:n
        %fi = varargin{i}; 
        x0 = GoldSection(f, e_gold, a, b, x0, i-2);
    end
    if abs(f(x0_prev) - f(x0)) < eps
        break;
    end
end
res = x0;
end