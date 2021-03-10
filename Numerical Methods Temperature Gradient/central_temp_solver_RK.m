function[Temp_matrix_initial, Temp_at_point] = central_temp_solver_RK(Temp_matrix_initial,num_rows,num_columns, alpha, Delta_x, Delta_y, h_a, k_a)

h = 0.0001;

Temp_Central = Temp_matrix_initial; %Matrix to store the central temperatures of the grid
Temp_at_point = zeros(4/h,1); %Initialize the size of the vector array to store temperatures for the required point
Temp_at_point(1) = 370;
lv_point = 2;
for t = 0.0001:h:4
    
    
    for lv_column = 2:num_columns-1
        for lv_row = num_rows-1:-1:2
            Temp_Central(lv_row, lv_column) = Rk_2(Temp_matrix_initial, lv_row, lv_column, h, Delta_x, Delta_y, alpha); %Solves for the central temperatures using RK2 as the IVP solver
        end
    end
    
    New_Temp_matrix_initial = Temp_Central; %Update the new iteration of the matrix for the new time step
    New_Temp_matrix_initial(num_rows,:) =  bottom_temp_finder(t, Delta_x, num_columns); %Find the bottom temperature at the new time step
    
    New_Temp_matrix_initial(2:num_rows-1,1) = left_temp_solver(New_Temp_matrix_initial, h_a, k_a, Delta_x, num_rows); %Find the left boundary temperature
    New_Temp_matrix_initial(2:num_rows-1,num_columns) = right_temp_solver(New_Temp_matrix_initial, h_a, k_a, Delta_x, num_rows, num_columns); %Find the right boundary temperature
    New_Temp_matrix_initial(1,:) = top_temp_solver(New_Temp_matrix_initial, h_a, k_a, Delta_y, num_columns);
    Temp_matrix_initial = New_Temp_matrix_initial; %Find the top boundary temperature
    
    Temp_at_point_low = ((1/3)*((Temp_matrix_initial(5,2)-Temp_matrix_initial(5,1))/0.5)) + Temp_matrix_initial(5,1); %Interpolate along x for the y = 0 cm grid
    Temp_at_point_high = ((1/3)*((Temp_matrix_initial(4,2)-Temp_matrix_initial(4,1))/0.5)) + Temp_matrix_initial(4,1); %Interpolate along x for the y = 0.5 cm grid
    Temp_at_point(lv_point) = (((Temp_at_point_high - Temp_at_point_low)/0.5)*(0.4)) + Temp_at_point_low; %Interpolate along y for the x = 0.4 cm grid
    lv_point = lv_point + 1;
end

end