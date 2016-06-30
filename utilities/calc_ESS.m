function [ ESS ] = calc_ESS( child_pars )

m = size(child_pars,1);
w = zeros(m,1);
for i = 1 : m
    w(i) = child_pars(i).weights;
end
cv = sum(w .^2);
ESS = 1 / cv ;

end

