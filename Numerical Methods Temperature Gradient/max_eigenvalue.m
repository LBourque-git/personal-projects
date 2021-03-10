function [lambda_max] = max_eigenvalue(A, nodes) %Finds the maximum value of a matrix using the Power Method

x = ones(nodes,1);
error = 1E-4;

norm_check = 1;
y =  x/sqrt(x'*x);

while norm_check > error %Stopping criterion
    
    lambda_star = y'*A*y;  %Update lambda star
    y = (1/(sqrt((A*y)'*(A*y))))*A*y;  %Update the eigenvector
    lambda_max = y'*A*y;  %Update the eigenvalue
    norm_check = abs(lambda_max-lambda_star);  %Update the norm
end



end