function [Temp_Top] = top_temp_solver(Temp_matrix_initial, h_a, k_a, Delta_y, num_columns) %Solves for the top boundary temperature for the transient case

denom = ((1/Delta_y) + (h_a/k_a)); %Sets the value for the denominator
Temp_Top = zeros(1,num_columns); %Pre-allocate the top matrix
for lv1 = 1:num_columns
    Temp_Top(lv1) = ((Temp_matrix_initial(2, lv1)/Delta_y) + (370*(h_a/k_a)))/denom; %Finds the temperature along the top boundary
end

end