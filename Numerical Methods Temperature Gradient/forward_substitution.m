function [Y] = forward_substitution(L,b, nodes)

Y = zeros(nodes, 1); %Pre-allocate Y

for lv1 = 1:nodes

    
    row_sum = 0;
    if(lv1~=1)
        for lv2 = 1:(lv1-1)
            row_sum = L(lv1,lv2)*Y(lv2) + row_sum; %Sum up the entries of the row to prepare the algebraic isolation equation
        end
    end
    
    Y(lv1) = (b(lv1) - row_sum) / L(lv1,lv1); %Solve the algebraic equation for the variable
end
end