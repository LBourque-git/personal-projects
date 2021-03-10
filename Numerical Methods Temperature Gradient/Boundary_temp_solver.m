function [T] = Boundary_temp_solver(T_c, h_a, k_a) %Solves for the entire matrix for case 2

T = zeros(5,3);

%Central points
T(4,2) = T_c(1);
T(3,2) = T_c(2);
T(2,2) = T_c(3);

%Bottom Boundary
T(5,1) = 370;
T(5,2) = 383.125;
T(5,3) = 370;

%Left Boundary
T(4,1) = (2*T(4,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(3,1) = (2*T(3,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(2,1) = (2*T(2,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));

%Right Boundary
T(4,3) = (2*T(4,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(3,3) = (2*T(3,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(2,3) = (2*T(2,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));

%Top Boundary
T(1,1) = (2*T(2,1) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(1,2) = (2*T(2,2) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
T(1,3) = (2*T(2,3) + ((h_a/k_a)*370)) / (2+(h_a/k_a));
end