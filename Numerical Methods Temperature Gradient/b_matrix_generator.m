function [b] = b_matrix_generator(nodes, num_columns, num_rows, Delta_x, h_a)

m = 0;

bottom_columns = num_columns;
b = zeros(nodes, 1); %Pre-allocate (b is zero for central points)

    for lv1 = 1:bottom_columns %Bottom generator
        
      
        b(lv1) = 370 + 50 * (1.05 * Delta_x*m*100 *(1 - Delta_x *100* m));
        m = m + 1; %Use with m
        
        
    end
    
    left_counter = bottom_columns + (num_rows-2);
    
    for lv2 = (bottom_columns+1):left_counter % Left boundary generator
        
        b(lv2)= -370* h_a;
        
    end
    
    top_counter = lv2 + (num_columns);
    
    for lv3 = (lv2+1):top_counter %Top boundary generator
        b(lv3) = -370* h_a;
    end
    
    right_counter = lv3 + (num_rows - 2);
    
    for lv4 = (lv3+1):right_counter %Right boundary generator
        b(lv4) =-370*h_a;
    end
    

end

