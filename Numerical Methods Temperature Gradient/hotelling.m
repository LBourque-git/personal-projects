function [eigen_val, eigen_vec] = hotelling(A, length_x)

[lambda1, v1] = Power_method(A,length_x); %First eigenvalue and eigenvector

B1 = A;
u1 = v1;

B2 = B1 - lambda1*(u1*u1');
[lambda2, u2] = Power_method(B2,length_x); %Second eigenvalue
epsi = 1E-5;
mu2 = lambda2 + epsi;
[lambda2_check, v2] = inv_power(A, length_x, mu2); %Second eigenvector


B3 = B2 - lambda2 * (u2*u2');
[lambda3, u3] = Power_method(B3, length_x); %Third eigenvalue
epsi = 1E-5;
mu3 = lambda3 + epsi;
[lambda3_check, v3] = inv_power(A, length_x, mu3); %Third eigenvector

eigen_val = eye(3,3); %Pre-allocates the D matrix

%Constructs the D matrix
eigen_val(1,1) = lambda1;
eigen_val(2,2) = lambda2;
eigen_val(3,3) = lambda3;

eigen_vec = [v1, v2, v3]; %Constructs the P matrix
end