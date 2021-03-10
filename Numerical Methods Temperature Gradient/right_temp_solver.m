function[Temp_Right] = right_temp_solver(Temp_matrix_initial, h_a, k_a, Delta_x, num_rows, num_columns) %Solves for the right boundary temperature for the transient case


denom = ((h_a/k_a) + (1/Delta_x)); %Sets the value for the denominator
Temp_Right = zeros(num_rows-2, 1); %Pre-allocates the right boundary matrix
lv_row = 2;
for lv1 = 1:num_rows-2
    Temp_Right(lv1) = ((Temp_matrix_initial(lv_row, num_columns-1)/Delta_x) + ((h_a/k_a)*370))/denom; %Finds the temperature for the right boundary
    lv_row = lv_row + 1;
end

end