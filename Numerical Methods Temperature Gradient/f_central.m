function [f] = f_central(Delta_x, Delta_y,Temp_matrix_initial, alpha, lv_row, lv_column) %The laplacian function


f = (1/alpha)*((( Temp_matrix_initial(lv_row,lv_column-1) + Temp_matrix_initial(lv_row,lv_column+1) - 2*Temp_matrix_initial(lv_row,lv_column) )/Delta_x^2 )+  (( Temp_matrix_initial(lv_row-1,lv_column) + Temp_matrix_initial(lv_row+1,lv_column) - 2*Temp_matrix_initial(lv_row,lv_column) )/Delta_y^2));

end