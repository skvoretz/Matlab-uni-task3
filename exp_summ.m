function s = exp_summ(X, Y, k)
if k < 0
    s = Y;
elseif k > 0
    Y = Y + X^(k) / factorial(k);
    s = exp_summ(X, Y, k-1);
elseif k == 0
    Y = Y + eye(size(X));
    s = exp_summ(X, Y, k-1);
end
end