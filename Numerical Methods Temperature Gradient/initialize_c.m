function [C] = initialize_c(h_a,k_a, alpha, Delta_x) %Computes the C matrix


C = zeros(3,3); %Pre-allocate the C matrix

%Generalized with delta x
C(1,1) = ((2/Delta_x)/(2 + (h_a/k_a))) - 4;
C(2,2) = ((2/Delta_x)/(2 + (h_a/k_a))) - 4;
C(3,3) = ((3/Delta_x)/(2 + (h_a/k_a))) - 4;

C(1,2) = 1;
C(2,1) = 1;
C(2,3) = 1;
C(3,2) = 1;
C = C*(((1/Delta_x^2))/alpha);
end