%% Question 3 Part a
A = [1 1 1; -6 -2 0; 1 1 -1];
C = [2 1 1];

Q = obsv(A,C);
if rank(Q) == length(A)
    disp('System is observable');
else
    disp('System is not observable');
end

%% Part b
Eig = eig(A)

for j = 1:length(Eig)
    Dt = [C; (Eig(j)*eye(3) - A)];
    if  Eig(j) < 0
        disp('Negative real part incompatible for PBH')
    elseif rank(Dt) == length(A)
        disp('System is detectable')
    else
        disp('System is not detectable')
    end
end

%% Part c
T = inv([C' (A'*C') [0;0;1]]');
T_inv = inv(T);

A_t = T_inv*A*T
C_t = C*T

if A_t(length(A_t),length(A_t)) < 0
    disp('Unobservable subspace is negative and asymptotically stable, thus detectable');
else
    disp('Not stable')
end


%% Part d
A_obs = A_t(1:2, 1:2);
p = [-1,-3];
L_1 = acker(A_obs',C_t(:,1:2)',p);

L_hat = [L_1 0]'
eig(A_t - L_hat*C_t)

%% Part e
L = T*L_hat
eig(A - L*C)


