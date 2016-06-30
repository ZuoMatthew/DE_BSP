function [ recs,samples ] = orig_to_01( recs,samples )

m = size(recs,1);          % Number of rectangles
dim = size(recs,2) / 2;    % Number fo dimensions

for i = 1 : dim
    min_dim = min(recs(:,2*i-1),[],1);
    max_dim = max(recs(:,2*i),[],1);
    recs(:,2*i-1:2*i) = (recs(:,2*i-1:2*i) - min_dim) / (max_dim - min_dim);
    for j = 1 : m
        samples{j,1}(:,i) = (samples{j,1}(:,i) - min_dim) / (max_dim - min_dim);
    end
end 

end

