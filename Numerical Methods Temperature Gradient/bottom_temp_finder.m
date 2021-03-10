function [Temp_bottom] = bottom_temp_finder(t, Delta_x, n) %Finds the temperature along the bottom boundary for transient case

%Conditions to evaluate the value of psi
if (t <= 2)
    psi = 1 + 0.05*sin(10*pi*t);
end
if (t > 2)
    psi = 0.05*exp(-0.5*(t-2)) + 0.95;
end


Temp_bottom = zeros(n,1); %Pre-allocate the bottom temperature matrix

for lv1 = 1:n
    x = Delta_x*(lv1-1)*100; %Use with meters (x is defined in cm)
    g = 1.05*x*(1-x)*psi; %Compute the g function based on psi
    Temp_bottom(lv1) = 370 + g*50; %Compute the bottom temperature
end

end