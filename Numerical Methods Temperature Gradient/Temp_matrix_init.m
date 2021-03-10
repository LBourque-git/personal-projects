function [Temp_matrix] = Temp_matrix_init(Temp_bottom,num_rows, num_columns) %Initializes the initial temperature at time t = 0 for the transient case

Temp_matrix = zeros(num_rows, num_columns); %Pre-allocate the matrix

Temp_matrix(:,:) = 370; %Set every value equal to 370 K

Temp_matrix(num_rows,:) = Temp_bottom; %Bottom boundary temperatures


end