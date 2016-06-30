function [ I_index,J_index ] = sim_par_h( h )

h_1c = h(:);
c = cumsum(h_1c);

sample = rand(1,1);
j=1;
while c(j) < sample
    j = j + 1;
end;
index = j;
[I_index,J_index] = ind2sub(size(h),index); 

end

