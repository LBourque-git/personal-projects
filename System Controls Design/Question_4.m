%% Question 4
% Setup
% This is all copied from assignment 2

% Define Constants from question
mp = 0.127; % kg, mass.
Lp = 0.33655; % m
mr = 0.257; % kg, mass.
Lr = 0.2159; % m
g = 9.81; % m/sˆ2
Dr = 0.0024; % N m s / rad
Dp = 0.0024; % N m s / rad
kt = 0.00768; % N m / A
km = kt; % V / ( rad / s)
eta_m = 0.69;
eta_g = 0.9;
Kg = 70;
Rm = 2.6; % Ohms

%M matrix
m11 = (mp * Lr^2)+(mr * Lr^2/3);
m12 = -Lr*Lp*mp/2;
m21 = m12;
m22 = mp*Lp^2/3;

M = [m11 m12; m21 m22];

%D matrix
d11 = Dr + (Kg*km*eta_m*eta_g/Rm);
d22 = Dp;

D = [d11 0; 0 d22];

%f matrix
f = [0 0; 0 -Lp*mp*g/2];

%b matrix
b = [Kg*eta_g*eta_m*kt/Rm; 0];
% Linearized Matrixes
A11 = zeros(2);
A12 = eye(2);
A21 = -inv(M)*f;
A22 = -inv(M)*D;

A = [A11 A12; A21 A22];

B = [0; 0; inv(M)*b];

C = [1 0 0 0; 0 1 0 0];

% Check Observability
OBSV = obsv(A,C);

if length(A) - rank(OBSV) == 0
    disp('System is observable')
else
    disp('System is not observable')
end

%% Part a
pole_k = [-2+3j -2-3j -10 -12];
K = place(A,B,pole_k)
Eig_k = eig(A-B*K)

%% Part b
P_k = ctrb(A-B*K,B)
if length(A) - rank(P_k) == 0
    disp('System is controllable')
else
    disp('System is not controllable')
end

%% Part c
pole_l = pole_k*4;
L = place(A',C',pole_l)'
Eig_l = eig(A-L*C)

%% Part d
A_cl = [A -B*K; L*C A-B*K-L*C];
B_cl = [B; B];
C_cl = [C zeros(2,length(C))];
Eig_cl = eig(A_cl)

%% Part e
x0 = [0 -10/180*pi 0 0]';
x0_hat = [0 0 0 0]';

tspan = (0:0.01:5);

[t,x] = ode45(@(t,x) sys(t,x,A_cl),tspan,[x0;x0_hat]);

x = x*180/pi;

x_hat = x(:,5:8);
v = zeros(length(x),1);


for j = 1:length(x)        %Solve v for all values of x
    v(j,1) = (-K*x_hat(j,1:4)') *pi/180;    %Transpose x as ode45 output is vertical
end

for j = 1:length(x)
    x_hatdot(j,:) = L*C*x(j,1:4)'  + (A-B*K-L*C)*x(j,5:8)';
end

for j = 1:length(x_hatdot)        %Solve v for all values of x
    v_dot(j,1) = (-K*x_hatdot(j,1:4)') *pi/180;    %Transpose x as ode45 output is vertical
end

disp('From the graphs, we see that all alphas go to zero between 1.5 to 2 seconds. The errors converge onto their expected parts by around 0.5 seconds. Thus all convergence is pretty fast')

figure(1)
plot(t,x(:,2),'b',t,x(:,6),'r')
grid on
title('Alpha vs Alpha hat over time')
xlabel('Time(s)')
ylabel('Deviation of Alpha (deg)')
legend('Alpha', 'Alpha hat')

figure(2)
plot(t,x(:,4),'b',t,x(:,8),'r')
grid on
title('Alphadot vs Alpha dothat over time')
xlabel('Time(s)')
ylabel('Deviation of Alphadot (deg/s)')
legend('Alphadot', 'Alpha dothat')


figure(3)
plot(t,v(:,1));
grid on
title('v input over time')
xlabel('Time (s)')
ylabel('Input (V)')

figure(4)
plot(t,v_dot(:,1));
grid on
title('v dot input over time')
xlabel('Time (s)')
ylabel('Input (V/s)')

figure(5)
subplot(2,1,1)
plot(x(:,2),x(:,4))
grid on
title('Alpha dot versus Alpha')
xlabel('Alpha')
ylabel('Alpha dot')

subplot(2,1,2)
plot(x(:,6),x(:,8))
grid on
title('Alpha hatdot versus Alpha hat')
xlabel('Alpha hat')
ylabel('Alpha hatdot')

function dx = sys(t,x,A)
    dx = zeros(length(A),1);
    dx = A*x;
end
