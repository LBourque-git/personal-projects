function [y_i] = Explicit_euler(y_0, lv_row, lv_column, h, Delta_x, Delta_y, alpha)

y_i = y_0(lv_row,lv_column) + h*f_central(Delta_x, Delta_y,y_0, alpha, lv_row, lv_column);

end