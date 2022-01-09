function dydx = odefun(x, y)
dydx = [y(2) y(1)+x.*2];
end