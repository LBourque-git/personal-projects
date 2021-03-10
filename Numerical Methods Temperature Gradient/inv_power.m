function [lambda_i, y] = inv_power(A, length_x, mu) %Inverse power method with shift on A

x = ones(length_x,1); %Pre-allocate the x matrix
error = 1E-11; %Error value

norm_check = 1;
y =  x/sqrt(x'*x);

B = A - mu*eye(3,3); %Set B

while norm_check > error %Stopping criterion
    
    lambda_star = y'*A*y; %Update lambda star
    z = B\y; %Solve for z
    y = 1/sqrt(z'*z) * z; %Update the eigenvector
    lambda_i = y'*A*y; %Update the eigenvalue
    norm_check = abs(lambda_i - lambda_star); %Update the norm
end

end