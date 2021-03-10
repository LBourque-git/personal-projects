function x0_49_91 = plot_49_91()
%Load data
load('Temp_49_91.mat');

%Initialize steps and dimensions
length = 49;
height = 91;
dim_length = 1;
dim_height = 2;

%Distance per step
dx = dim_length/(length - 1);
dy = dim_height/(height - 1);

%Initialize array for plot
x0_49_91 = zeros(height,2);

for lv1 = 1 : height
    if lv1 == 1
        x0_49_91(lv1,1) = Temp(lv1,:);
        x0_49_91(lv1,2) = dy*(lv1 - 1);
    else
        new_lv = lv1 + length;
        x0_49_91(lv1,1) = Temp(new_lv,:);
        x0_49_91(lv1,2) = dy*(lv1 - 1);
    end
end
plot(x0_49_91(:,2),x0_49_91(:,1))
end

