function [exp_m] = exp_matrix(D,t)

D = D*t;

exp_m = zeros(3,3);

exp_m(1,1) = exp(D(1,1));
exp_m(2,2) = exp(D(2,2)); 
exp_m(3,3) = exp(D(3,3)); 


end
