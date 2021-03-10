function [lambda_max, y] = Power_method(A, x_length) %Power method

x = ones(x_length,1); %Pre-allocate the x matrix
error = 1E-11; %Error value

norm_check = 1;
y =  x/sqrt(x'*x);

while norm_check > error %Stopping criterion
    
    lambda_star = y'*A*y; %Update lambda star
    y = (1/(sqrt((A*y)'*(A*y))))*A*y; %Update the eigenvector
    lambda_max = y'*A*y; %Maximum eigenvalue
    norm_check = abs(lambda_max-lambda_star); %Update the norm
end



end