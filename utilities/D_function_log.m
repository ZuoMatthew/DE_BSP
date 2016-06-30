function [ y ] = D_function_log( X )

n = length(X);
a = 0;
b = gammaln(sum(X(:)));
for i = 1 : n
    a = a + gammaln(X(i));
end
y = a - b;
end

