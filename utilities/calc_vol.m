function [ vol ] = calc_vol( rec )

n_dim = length(rec) / 2;
vol = 1;
for i = 1 : n_dim
    vol = vol * abs(rec(1,2 * i -1) - rec(1,2 * i));
end

end

