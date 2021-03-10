function [y_i] = Rk_2(y_0, lv_row, lv_column, h, Delta_x, Delta_y, alpha)
    
k1 = f_central(Delta_x, Delta_y,y_0, alpha, lv_row, lv_column);
k2 = f_central(Delta_x, Delta_y,y_0, alpha, lv_row, lv_column) + (h/2)*k1;

y_i = y_0(lv_row,lv_column) + h*k2;

end