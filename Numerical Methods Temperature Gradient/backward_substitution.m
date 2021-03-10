function [X] = backward_substitution(U,Y, nodes)

X = zeros(nodes,1);

for lv1 = nodes:-1:1
    
    row_sum = 0;
    
    if(lv1~=nodes)
        for lv2 = nodes:-1:(lv1+1)
            row_sum = U(lv1, lv2)*X(lv2) + row_sum; %Sums up the entries in the row to prepare the algebraic isolation equation
        end
    end
    
    X(lv1) = (Y(lv1) - row_sum) / U(lv1,lv1); %Solve the algebraic equation 
    
end

end