function [ left,right ] = separate_samples( samples,midpoint,dim )

samples_vector = samples{1};
n = size(samples_vector,1);
left_vector = [];
right_vector = [];

for i = 1 : n
    if samples_vector(i,dim) <= midpoint
        left_vector = [left_vector;samples_vector(i,:)];
    else
        right_vector = [right_vector;samples_vector(i,:)];
    end
end
left{1} = left_vector;
right{1} = right_vector;

end

