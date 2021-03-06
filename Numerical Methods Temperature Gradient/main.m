clear
clc

tic;
%% Setting values and constants

num_columns = 3;
num_rows = 5;
Delta_x = (1/(num_columns-1))*(10^(-2)); % In meters
Delta_y = (2/(num_rows-1))*(10^(-2)); % In meters
nodes = num_columns * num_rows; % Number of codes
h_a = 17; 
k_a = 379.9; 
rho = 8960; 
cp = 385;
alpha = rho*cp/k_a;

%% Finding LU decomposition

b = b_matrix_generator(nodes, num_columns, num_rows, Delta_x, h_a); %Generates the b matrix
A = A_matrix_generator(nodes, num_columns, num_rows, Delta_x, Delta_y, h_a, k_a); %Generatres the A matrix
[L,U] = LU_matrix_generator_fast(A, nodes); %LU decomposition method


%% Solve for the temperature
Y = forward_substitution(L,b, nodes); %Forward substitution
Temp = backward_substitution(U, Y, nodes); %The temperature distribution of the grid for the steadt state analysis

toc;

%% Find the T for the Jacobi and the max eigenvalue (Proving Jacobi Convergence)
[D_j, L_j, U_j] = Jacobi_matrix_finder(A,nodes); %Finds the D,L, and U matrices for the Jacobi iteration
D_j_inv = invert_diagonal_matrix(D_j,nodes); %Inverts the D matrix
T = -D_j_inv*(L_j+U_j); %Calculates the T matrix
lambda_max = max_eigenvalue(T, nodes); %Finds the maximum eigenvalue of T

%% IVP Problem Euler
Temp_bottom_initial = bottom_temp_finder(0,Delta_x,num_columns); %Initializes the bottom boundary temperature distribution
Temp_matrix_initialized = Temp_matrix_init(Temp_bottom_initial,num_rows, num_columns); %Initializes the entire grid's temperature distribution at time 0
[Temp_central_EU, Temp_at_point_EU] = central_temp_solver(Temp_matrix_initialized,num_rows,num_columns, alpha, Delta_x, Delta_y, h_a, k_a); % Returns the grid temperature distribution as well as the temperature at the required point

%% IVP Problem RK2
Temp_bottom_initial_RK = bottom_temp_finder(0,Delta_x,num_columns); %Initializes the bottom boundary temperature distribution
Temp_matrix_initialized_RK = Temp_matrix_init(Temp_bottom_initial_RK,num_rows, num_columns); %Initializes the entire grid's temperature distribution at time 0
[Temp_central_RK, Temp_at_point_RK] = central_temp_solver_RK(Temp_matrix_initialized_RK,num_rows,num_columns, alpha, Delta_x, Delta_y, h_a, k_a); %Returns the grid temperature distribution as well as the temperature at the required point

time = time_initialize; %Initializes the x-axis for the plot
plot_temperature(time,Temp_at_point_EU, Temp_at_point_RK); %Plots the temperature vs time for the given point


%% Case 2
Delta_x = 0.5; %Re-declare the variables to work in cm this time 
h_a = 0.001;
k_a = 3.948;
rho = 0.00894;
alpha = rho*cp/k_a;

C = initialize_c(h_a,k_a, alpha, Delta_x); %Initializes the C matrix
r = initialize_r(h_a,k_a,alpha); %Initializes the r matrix
[D, P] = hotelling(C, 3); %Hotelling method to find D and P
T_0 = [370;370;370]; %Initial temperature at the central points
t = 4; %Time instance for which we want the temperature distribution
T_t = Temp_finder_C_r(P,D,C,r,t, T_0); %The temperature at time t for the central points
T_total = Boundary_temp_solver(T_t, h_a, k_a); %The temperature distribution for the entire grid at time t


