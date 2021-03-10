function [A] = A_matrix_generator(nodes, num_columns, num_rows, Delta_x, Delta_y, h_a, k_a)

A = zeros(nodes); %Pre-allocate A
m = 1;
left_beginning = num_columns + 1 ; %Boundary limit counters
bottom_beginning = 1; %Boundary limit counters
top_beginning = left_beginning + (num_rows-2); %Boundary limit counters
right_beginning = top_beginning + num_columns; %Boundary limit counters

for lv1 = 1:num_columns %Bottom boundary
    A(lv1, lv1) = 1;
    m = m+1;
end

end_counter = nodes-(num_rows-2)*(num_columns-2) + 1; %Initialize counter

for lv2 = (num_columns+1):(num_columns + (num_rows-2)) %Left boundary
    A(m, lv2) = -(k_a/Delta_x + h_a);
    A(m, end_counter) = k_a/Delta_x;
    end_counter = end_counter + 1;
    m = m+1;
end

lv5 = nodes-(num_rows-2)*(num_columns-2)+(num_rows-2); %Counter

for lv3 = lv2+1:(lv2+num_columns) %Top boundary
    if lv3 == (lv2+1)
        lv4 = num_columns + (num_rows-2);
        A(m, lv4) = k_a/Delta_x;
    end
   
    if lv3 == (lv2+num_columns)
        lv4 = nodes-(num_rows-2)*(num_columns-2);
        A(m, lv4) = k_a/Delta_x;
    end
    A(m,lv3) =  -(k_a/Delta_x + h_a);
    if (lv3~=lv2+1) && (lv3~=(lv2+num_columns))
    A(m, lv5) = k_a/Delta_x;
    lv5 = lv5+(num_rows-2);
    end
    m= m+1;
end

lv7 = nodes-(num_rows-2)+1;
for lv6 = lv3+1:(lv3+num_rows-2) %Right boundary
    
    A(m, lv6) = -(k_a/Delta_x + h_a);
    A(m, lv7) = k_a/Delta_x;
    lv7 = lv7 +1;
    m = m+1;
end

row_counter = 1;
column_counter = 1;
max_column = num_columns-2;
max_rows = num_rows-2;

for lv8 = lv6+1:nodes %Center Diagonal
    A(m,lv8) = (2*k_a/Delta_x^2) + (2*k_a/Delta_y^2);
    
    if (row_counter > max_rows)
        row_counter = 1;
        column_counter = column_counter + 1;
    end
    if (column_counter == 1) && (column_counter ~= max_column) %First Column
        A(m, left_beginning) = -(k_a/Delta_x^2);
        A(m, lv8+(num_rows-2)) = -(k_a/Delta_x^2);
        left_beginning = left_beginning + 1;
    end
    if (column_counter ==1) && (column_counter == max_column) %Max and min column
        A(m, left_beginning) = -(k_a/Delta_x^2);
        A(m, right_beginning) = -(k_a/Delta_x^2);
        left_beginning = left_beginning + 1;
        right_beginning = right_beginning + 1;
    end
    if (column_counter ~= 1) && (column_counter ~= max_column) %In between columns
        A(m, lv8-(num_rows-2)) = -(k_a/Delta_x^2);
        A(m, lv8+(num_rows-2)) = -(k_a/Delta_x^2);
    end
    
    if(column_counter == max_column) && (max_column ~= 1) %End column
        A(m, right_beginning) = -(k_a/Delta_x^2);
        A(m, lv8 - (num_rows - 2)) = -(k_a/Delta_x^2);
        right_beginning = right_beginning + 1;
    end
    
    if(row_counter == 1) && (row_counter ~= max_rows) %First Row
        A(m, bottom_beginning+1) = -(k_a/Delta_y^2);
        A(m, lv8+1) = -(k_a/Delta_y^2);
        bottom_beginning = bottom_beginning + 1;
    end
    if (row_counter ~= 1) && (row_counter ~= max_rows) %In between rows
        A(m, lv8 + 1) = -(k_a/Delta_y^2);
        A(m, lv8 - 1) = -(k_a/Delta_y^2);
    end
    if (row_counter == max_rows) %Max row
        A(m, top_beginning + 1) = -(k_a/Delta_y^2);
        A(m, lv8 - 1) = -(k_a/Delta_y^2);
        top_beginning = top_beginning + 1;
    end
    m = m+1;
    
    row_counter = row_counter + 1; %Update row counter
     
    
end
end