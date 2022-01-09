% VAR 2

%#ok<*NOPTS>
%% Paragraph 1
clc;
%%{
% 1-st var
k = 5; % кол-во точек для ginput
n = 30;
a = -1;
b = 2;

x = linspace(a, b, n);

fun = @(x) sin(x) - x.^3 - x + 1;
plot(x, fun(x));
hold on;
grid on;
[x_i, y_i] = ginput(k);
plot(x_i, y_i, 'r*');
for i = 1:length(x_i)
    x = fzero(fun, x_i(i))
end
%}

%{
% 2-nd var
k = 5; % кол-во точек для ginput
n = 30;
a = -1;
b = 2;

x = linspace(a, b, n);

fun = @(x) sin(x) - x.^3 - x + 1;
point = fzero(fun, 0)

f1 = @(x) sin(x);
f2 = @(x) x.^3 + x - 1;
plot(x, f1(x), x, f2(x));
hold on;
grid on;
[x_i, y_i] = ginput(k);
plot(x_i, y_i, 'r*');
%}
%% Paragraph 2
clc;
f = @(x) (x == 0).*0 + (x ~= 0).*(x.*cos(log(abs(x))));

a = -8;
n = 100;
x = linspace(a, abs(a), n);
y = zeros(size(x));
for i = 1:n
    y(i) = fzero(f, x(i));
end

plot(x, y);
grid on;
hold on;
x = linspace(a, abs(a), 100);
plot(x, f(x));
legend('Результат', 'f(x)');
    
%% Paragraph 8
clc;
% y1 = y
% y2 = y'

% Система:
% y1' = y2
% y2' = 2*x + y1

n = 10;
xmesh = linspace(0, 1, n);
solinit = bvpinit(xmesh, [-1; 0]);
sol = bvp4c(@odefun, @bcfun, solinit);

% в sol.x содержатся координаты сетки
% в sol.y матрица
% sol.y(1, :) соответствует значениям функции y1 в sol.x(:)
% sol.y(2, :) соответствует значениям функции y2 в sol.x(:)

plot(sol.x, sol.y(1,:), 'r*');
xlabel('x');
ylabel('y');
grid on;
hold on;

f = @(x) sinh(x)./sinh(1) - 2*x;
plot(xmesh, f(xmesh));

%% Paragraph 3
clc;
X = [1 1; 1 1]
k = 100;
% Version 1
disp('Степенной ряд:');
Y1 = exp_summ(X, zeros(size(X)), k)

% Version 2
disp('ode45:');
Q = ode45(@(t, Y) [X(1, 1)*Y(1)+X(1, 2)*Y(3); X(1,1)*Y(2)+X(1,2)*Y(4); X(2,1)*Y(1)+X(2,2)*Y(3); X(2,1)*Y(2)+X(2,2)*Y(4)], [0, 1], eye(size(X)));
Y2 = transpose(reshape(Q.y(:, end), 2, 2))
% Classic version - Version 3
disp('expm:');
Y3 = expm(X)

%% Paragraph 4
clc;
figure;
line([0, 0], [2, 7], 'Color', 'red');
line([0, 5], [7, 7], 'Color', 'red');
line([5, 5], [7, 2], 'Color', 'red');
line([0, 5], [2, 2], 'Color', 'red');
axis([0 5 2 7])
hold on;
grid on;

% x'' = -a*x

% x1 = x
% x2 = x'

% x1' = x2
% x2' = -a*x1



a = -2;
%a = 0;
%a = 0.5;

%y0:
s0_x = 0;
s0_y = 4;
speed_x = 3;
speed_y = 4;
y0 = [s0_x, speed_x, s0_y, speed_y];

%tspan:
tb = 0;
te = 100;
%n = 1000;
%tspan = linspace(tb, te, n);


%options:
options = odeset('Events', @event_1, 'MaxStep', 1e-2);

odef = @(t, y) [y(2); -a*y(1); y(4); -a*y(3)];

iter = 20;
x_r = [];
y_r = [];

for i = 1:iter 
    %tspan = linspace(tb, te, n);
    tspan = [tb te];
    sol = ode45(odef, tspan, y0, options);
    x_r = [x_r sol.y(1, :)];
    y_r = [y_r sol.y(3, :)];
    disp(sol.ie);
    disp(tb);
    switch sol.ie(1)
        case 1
            speed_x = -sol.y(2,end);
        case 2
            speed_x = -sol.y(2,end);
        case 3
            speed_y = -sol.y(4,end);
        case 4
            speed_y = -sol.y(4,end);
    end
    y0 = [sol.y(1, end); speed_x; sol.y(3, end); speed_y];
    tb = sol.xe;
end
comet(x_r, y_r);
%% Paragraph 5
clc;
figure;
x10 = 3;
x20 = 2;
x30 = 1;
y10 = 3;
y20 = 2;
y30 = 1;

x0 = [x10, x20, x30];
y0 = [y10, y20, y30];
dx_dt0 = [5; 5; 5];
dy_dt0 = [10; 0; 5];
t0 = 0;
t1 = 10;

begin = [x10, x20, x30, y10, y20, y30, dx_dt0(1,1), dx_dt0(2,1), dx_dt0(3,1), dy_dt0(1,1), dy_dt0(2,1), dy_dt0(3,1)];
[t, y] = ode45(@ft5, [t0 t1], begin);

plot3(y(1, :), y(2, :), y(3, :));
grid on;
hold on;
%disp(y);
% x1 = C1*e^(at) + C2/e^(at) + C3*t + C4
% x2 = C5*e^(at) + C6/e^(at) + C7*t + C8
% a = sqrt(-G*m2/||x1-x2||^3 - -G*m1/||x1-x2||^3)

%% Paragraph 7
clc;
figure;
% Функция Ляпунова для 1-й системы:
% V(x,y, t) = x^2 + y^2 >= 0
% Проверяем:
% 2*x*(x^3 - y) + 2*y*(x + y^3) = 2*x^4 - 2xy + 2xy + 2*y^4 = 2*x^4 + 2*y^4 >= 0
% Тогда по теореме Четаева решение неустойчиво  


% Функция Ляпунова для 2-й системы:
% V(x,y, t) = x^2 + y^4
% Проверяем:
% 2*x*(2*y^3-x^5) + 4y^3(-x - y^3 + y^5) = -2(y^6 + x^6 - y^8) <= 0 (в
% некоторой малой окресности) - нам её достаточно для 2-й теоремы Ляпунова
% Тогда по 2-й теореме Ляпунова решение устойчиво  

% Для первой системы:
tspan = [0 35];
y0 = [0.001 0.1];
opt = odeset('OutputSel',[1 2], 'OutputFcn','odephas2');
sol = ode45(@(t, y) [y(1)^3 - y(2); y(1)+ y(2)^3], tspan, y0, opt);
disp(sol.y);
plot(sol.y(1, :), sol.y(2,:), 'k->');
grid on;

% Для второй системы:
figure;
tspan = [0 35];
y0 = [0.4 1];
opt = odeset('OutputSel',[1 2], 'OutputFcn','odephas2');
sol = ode45(@(t, y) [2*y(2)^3 - y(1)^5; -y(1) - y(2)^3 + y(2)^5], tspan, y0, opt);
disp(sol.y);
plot(sol.y(1, :), sol.y(2,:), 'm->');
grid on;

%% Paragraph 9
clc;

x0 = [1; 1];
f = @(x) (x(1,:) - 1).^2 + (x(2,:) - 1).^2 - 3*x(1,:);
f1 = @(x) 2*(x(1,:) - 1) - 3;
f2 = @(x) 2*(x(2,:) - 1);

res = CoorDescent(f, x0, f1, f2);
disp(res);
disp(fminsearch(f, x0));
disp(fminunc(f, x0));
x = [1:10; 1:10];
[X, Y] = meshgrid(x(1,:), x(2,:));
Z = (X - 1).^2 + (Y - 1).^2 - 3*X;
surf(X, Y, Z, 'EdgeColor', 'none');
colormap default;
grid on;
figure;
[CMatr, h] = contour(X,Y,Z, 20);
clabel(CMatr, h);
grid on;
 
%% Paragraph 6
clc;

params = GenerateTable(6,3);
var = 1;
SavePrivateRyan(params, var);

%% Paragraph 10
clc;
%%{
fighandle1 = figure('Name','func1, empty axes','NumberTitle','off');
res = plotFT(fighandle1, @func1, @ftfunc1, 0.4, [-40 40], [-50 50]);
%}

%{
fighandle2 = figure('Name','func2, empty axes','NumberTitle','off');
res = plotFT(fighandle2, @func2, @ftfunc2, 0.4, [-10 10], [-50 50]);
%}

%{
fighandle3 = figure('Name','func3, empty axes','NumberTitle','off');
res = plotFT(fighandle3, @func3, [], 0.4, [-10 10], [-50 50]);
%}

%{
fighandle4 = figure('Name','func4, empty axes','NumberTitle','off');
res = plotFT(fighandle4, @func4, [], 0.4, [-10 10], [-50 50]);
%}


