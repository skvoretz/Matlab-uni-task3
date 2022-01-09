function SavePrivateRyan(params, var)
fig = params.f;
P = params.p;
n = params.n;
m = params.m;

zer = zeros(1, m*n);

P = reshape(P, [1, m*n]);
mas = zeros(1, n*m); %веса
remem = ones(1, n*m); %нужно ли заходить в клетку - строим матрицу рёбер
graph = zeros(n*m, n*m); %что с чем соединяется

mas(end) = 1;

for i = 1:m*n
    %углы
    if i == m*n
        graph(i-1, i) = 1;
        graph(i-n, i) = 1;
        if var == 1
            graph(i-n-1, i) = 1; %
        end
    elseif i == m*n - (n-1)
        graph(i+1, i) = 1;
        graph(i-n, i) = 1;
        if var == 1
            graph(i-n+1, i) = 1; %
        end
    elseif i == n
        %graph(i-1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i+n-1, i) = 1; % 
        end
    elseif i == 1
        graph(i+1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i+n+1, i) = 1; % 
        end
    %горизонтальные стороны
    elseif (2 <= i) && (i <= n-1)
        %graph(i-1, i) = 1;
        graph(i+1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i+n-1, i) = 1; % 
            graph(i+n+1, i) = 1; % 
        end
    elseif (n*m - n + 2 <= i) && (i <= m*n -1) 
        %graph(i-1, i) = 1;
        graph(i+1, i) = 1;
        graph(i-n, i) = 1;
        if var == 1
            graph(i-n-1, i) = 1; % 
            graph(i-n+1, i) = 1; % 
        end
    %вертикальные стороны
    elseif mod(i, n) == 1
        %graph(i-n, i) = 1;
        graph(i+1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i-n+1, i) = 1; % 
            graph(i+n+1, i) = 1; %
        end
    elseif mod(i, n) == 0
        %graph(i-n, i) = 1;
        graph(i-1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i-n-1, i) = 1; % 
            graph(i+n-1, i) = 1; %
        end
    %внутренний квадрат
    else
        graph(i-n, i) = 1;
        %graph(i-1, i) = 1;
        graph(i+1, i) = 1;
        graph(i+n, i) = 1;
        if var == 1
            graph(i-n-1, i) = 1; % 
            graph(i+n-1, i) = 1; %
            graph(i-n+1, i) = 1; % 
            graph(i+n+1, i) = 1; %
        end
    end
end
%disp(graph);
while isequal(remem, zer) == 0
    %disp(remem);
    %disp(mas);
    %disp(P);
    
    for j = 1:n*m
        i = m*n - j + 1;
        indx = find(graph(:,i));
        for num = 1:length(indx)
            k = indx(num);
            t = mas(k);
            if remem(k) == 1
                k_indx = find(graph(:,k));
                mas(k) = max(mas(k_indx) .* P(k_indx)); 
            end
            if t ~= mas(k)
                remem(k_indx) = 1;
            end
            remem(k) = 0;
        end
        remem(m*n) = 0;
        remem(1) = 0;
    end
end
%disp(mas);
i = 1;
chance = 1-P(i);
x = zeros(1, n*m);
y = zeros(1, n*m);
iter = 1;
x(1) = mod(i,n) - 0.5;
y(1) = mod(i,m) - 0.5;
%disp('-----------------');
while i ~= m*n
    if P(i) == 1
        disp('BOOM!');
        break;
    end
    indx = find(graph(:,i));
    %disp(indx);
    %disp(min(mas(indx) + P(indx)));
    way = mas(indx) .* P(indx);
    %disp(i);
    %disp(mas);
    %disp(indx);
    %disp(way);
    j = max(indx(find(way == max(way))));
    %disp(j);
    chance = chance * P(j);
    iter = iter + 1;
    %disp(fix(j/n));
    
    if mod(j,n) ~= 0
        %disp(size(x(iter)));
        %disp(size(mod(j,n) - 0.5));
        x(iter) = mod(j,n) - 0.5;
    else 
        x(iter) = n - 0.5;
    end
    if fix(j/n) ~= j/n
        y(iter) = fix(j/n) + 0.5;
    else
        y(iter) = fix(j/n) - 0.5;
    end
    i = j;
end
disp('Max chance for surviving =');
disp(chance);
mas(1) = chance;
plot(x(find(x)), y(find(y)), 'm*-');

t_x = 0:n*m-1;
t_x = mod(t_x, n);
t_x(n:n:end, 1) = n;

t_y = 1:n*m;
t_y = fix(t_y/n)+1;
t_y(n:n:end) = t_y(n:n:end)-1;

t_x = t_x + 0.5;
t_y = t_y - 0.25;

num = mas;
for i = 1:n*m
    text(t_x(i), t_y(i), num2str(num(i))); % выводим минимум
end
end