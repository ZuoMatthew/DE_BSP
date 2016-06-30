function [ h ] = calc_h( log_q )

m = size(log_q,1);
n = size(log_q,2);
h = ones(m,n);
r = 1;
for i = 1 : m
    for j = 1 : n
        temp_q = exp(r .* (log_q - log_q(i,j)));
        h(i,j) = 1 / sum(temp_q(:));
    end
end


if m == 1 && n == 1
    h = 1;
else
    while max(h(:)) >= 0.9
        for i = 1 : m
            for j = 1 : n
                temp_q = exp(r .* (log_q - log_q(i,j)));
                h(i,j) = 1 / sum(temp_q(:));
            end
        end       
        r = r * 0.8;
    end
end

end

