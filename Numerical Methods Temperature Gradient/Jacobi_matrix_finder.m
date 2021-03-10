function[D,L,U] = Jacobi_matrix_finder(A, nodes);

%Pre-allocate the D, L, and U matrices
D = zeros(nodes);
L = zeros(nodes);
U = zeros(nodes);

for lv1 = 1:nodes %Finds the D matrix by taking the diagonal entries of the matrix A
    D(lv1,lv1) = A(lv1,lv1);
end

for lv2 = 1:nodes %Takes the lower triangular entries of the matrix A to form the L matrix   
    lv3 = lv2+1:nodes;    
    L(lv3,lv2) = A(lv3,lv2);
end

for lv4 = 1:nodes %Takes the upper triangular entries of the matrix A to form the U matrix
    lv5 = lv4+1:nodes;
    U(lv4,lv5) = A(lv4,lv5);
end

end