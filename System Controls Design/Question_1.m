p = [-10+10j -10-10j];
A = [0 8; 1 10];
C = [0 1];

L = place(A',C',p)'

Ahat = A-L*C
eig(Ahat)