function[Temp_Left] = left_temp_solver(Temp_matrix_initial, h_a, k_a, Delta_x, num_rows) %Finds the temperature for the left boundary for the transient case



denom = ((h_a/k_a) + (1/Delta_x)); %Sets the denominator 
Temp_Left = zeros(num_rows-2, 1); %Pre-allocates the left temperature matrix
lv_row = 2;
for lv1 = 1:num_rows-2
    Temp_Left(lv1) = ((Temp_matrix_initial(lv_row, 2)/Delta_x) + ((h_a/k_a)*370))/denom; %Finds the temperature for the left boundary points
    lv_row = lv_row + 1;
end

end