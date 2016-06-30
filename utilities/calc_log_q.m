function [ log_q ] = calc_log_q( recs,samples )

nb_recs = size(recs,1);

vol = zeros(nb_recs,1);
nb_samples = zeros(nb_recs,1);
alpha = zeros(nb_recs,1);
for i = 1 : nb_recs
    temp_rec = recs(i,:);
    vol(i) = calc_vol(temp_rec);
    nb_samples(i) = size(samples{i},1);
    alpha(i) = max(min(nb_samples(i) / 200, 0.5),0.1);
end

c0 = sum(nb_samples.* log(vol),1);
D_alpha = D_function_log(alpha);
D_nb_samples = D_function_log(nb_samples + alpha);
log_q = D_nb_samples - D_alpha - c0;

end

