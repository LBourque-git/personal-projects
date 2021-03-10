function [T] = Temp_finder_C_r(P,D,C,r,t, T_0) %Finds the temperature at time t using P, D, C, and r matrices

T = P*exp_matrix(D,t)*(P\(T_0 + C\r)) - C\r; %Value for the temperature

end