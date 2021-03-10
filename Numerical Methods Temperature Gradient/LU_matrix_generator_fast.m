function [L,U] = LU_matrix_generator_fast(A, nodes)

L = eye(nodes); %Pre-allocate
U = A; %Pre-allocate
for lv1 = 1:(nodes-1) %Constructs L and U matrix column by column
    lv2 = (lv1+1):nodes;
    L(lv2,lv1) = U(lv2,lv1)/U(lv1,lv1); %Store m value for the L matrix
    U(lv2,:) = U(lv2,:) - L(lv2,lv1)*U(lv1,:); %Find the U matrix
end

end