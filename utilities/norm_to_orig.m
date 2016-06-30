function [ o_recs,o_samples ] = norm_to_orig( ref_recs,n_recs,n_samples )

nb_recs = size(n_recs,1);     % Number of rectangles
dim = size(n_recs,2) / 2;       % Number fo dimensions

o_recs = zeros(size(n_recs));
o_samples = cell(size(n_samples));
for i = 1 : dim
    min_dim = min(ref_recs(:,2*i-1),[],1);
    max_dim = max(ref_recs(:,2*i),[],1);
    o_recs(:,2*i-1:2*i) = n_recs(:,2*i-1:2*i) * (max_dim - min_dim) + min_dim;
    for j = 1 : nb_recs
        if isempty(n_samples{j})
            o_samples{j} = [];
        else
            o_samples{j}(:,i) = n_samples{j}(:,i) * (max_dim - min_dim) + min_dim;
        end
    end
end    

end

