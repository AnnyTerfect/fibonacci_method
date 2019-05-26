function [min_point] = fibonacci_method(f, a, b, accurate)
A = []; B = []; %左右端点列表
T1 = []; T2 = []; %左右试点列表
lower = []; %左试点函数值是否小于右试点
A(1) = a; B(1) = b; %试点初值
%设定初始参数

n = 1;
fib = [];
while true
    fib(n) = fibonacci(n);
    if fib(n) > 1 / accurate
        break
    end
    n = n + 1;
end
%循环找所需的n并构建fibonacci列

T1(1) = b - fib(n - 1) / fib(n) * (b - a);
T2(1) = a + fib(n - 1) / fib(n) * (b - a);
%计算首对试点

for k = 2: n - 2
    if f(T1(k - 1)) < f(T2(k - 1))
        A(k) = A(k - 1);
        B(k) = T2(k - 1);
        T2(k) = T1(k - 1);
        T1(k) = B(k) - fib(n - k + 1) / fib(n - k + 2) * (B(k) - A(k));
        lower(k - 1) = true;
    else
        A(k) = T1(k - 1);
        B(k) = B(k - 1);
        T1(k) = T2(k - 1);
        T2(k) = A(k) + fib(n - k + 1) / fib(n - k + 2) * (B(k) - A(k));
        lower(k - 1) = false;
    end
    %根据函数值关系更新试点和区间端点
    %注意由于下标从1开始而公式中符号下标从0开始故下标存在细微差别
end

T1(n - 2) = (A(n - 2) + B(n - 2)) / 2;
T2(n - 2) = T1(n - 2);

for k = 1: n - 3
    disp(['第', num2str(k), '轮：']);
    disp(['a', num2str(k - 1), ' = ', num2str(A(k)) ' b', num2str(k - 1), ' = ' num2str(B(k))]);
    disp(['t' num2str(k) ' = ' num2str(T1(k)) ' t' num2str(k) ''' = ' num2str(T2(k))]);
    disp(['f(t' num2str(k) ') = ' num2str(f(T1(k))) ' f(t', num2str(k), ''') = ' num2str(f(T2(k)))]);
    if lower(k)
        disp(['f(t', num2str(k), ') < ' 'f(t' num2str(k) ''')']);
    else
        disp(['f(t', num2str(k), ') > ' 'f(t' num2str(k) ''')']);
    end
    fprintf('\n');
end

disp('最后一轮');
disp(['t' num2str(n - 2) ' = t' num2str(n - 2) ''' = ' num2str(T2(n - 2))]);
end

