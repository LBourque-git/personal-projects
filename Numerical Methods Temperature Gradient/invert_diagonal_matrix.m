function[D_inv] = invert_diagonal_matrix(D,nodes)

D_inv = zeros(nodes); %Pre-allocate the inverse matrix

for lv1 = 1:nodes
    D_inv(lv1,lv1) = 1/(D(lv1,lv1)); %Take inverse of each diagonal entry and store it into the diagonal matrix
end

end