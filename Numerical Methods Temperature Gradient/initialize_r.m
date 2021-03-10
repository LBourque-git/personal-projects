function [r] = initialize_r(h_a, k_a, alpha) %Initializes the r matrix

r = zeros(3,1); %Pre-allocates the r matrix
r(1) = (((2*370)*(h_a/k_a)) / (2 + (h_a/k_a))) + 383.125; 
r(2) = ((2*370)*(h_a/k_a)) / (2 + (h_a/k_a));
r(3) = ((3*370)*(h_a/k_a)) / (2 + (h_a/k_a));
r = r*(4/alpha); %Multiplies by the coefficient
end