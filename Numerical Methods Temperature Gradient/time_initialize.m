function [time]= time_initialize()
time = linspace(0,4,40001);
counter = 0;
for lv1 = 1:40001
    time(lv1) = counter;
    counter = counter + 0.0001;
end
end