function [ score ] = calc_score_logpi( recs,samples,log_q )

beta = 1.0;
n_recs = size(recs,1);
score = -beta * n_recs + log_q;

end

