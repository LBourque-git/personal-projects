%% Project 4 - Detonation
% Louis Bourque - 260714602

clc
clear

[Vweak,Pweak] = weak(); %weak detonation from CEA


% Enthalpy of Formation (kJ/kmol)
hfCO = -110530;
hfCO2 = -393520;
hfO = 249190;
hfO2 = 0;

%% Part 1

cp_ini = 0.9959; %kJ/(kg K)
T_ini = 298; %(K)

%CEA Results
nCO = 0.38166;
nCO2 = 0.40287;
nO = 0.04929;
nO2 = 0.16618;

y_react = 1.3977;
y_burn = 1.1253;

% Reactants
COini = 0.66667;
O2ini = 0.33333;

% Molecular Weight of Reactancts (kg/kmol) or (g/mol)
COw = 28.011;
O2w = 31.999;

% Estimate q
nhf_react = (COini*hfCO + O2ini*hfO2);
nhf_prod = (nCO*hfCO + nCO2*hfCO2 + nO*hfO + nO2*hfO2);
nMW = (COw*COini + O2w*O2ini);

q_estimate = (nhf_react - nhf_prod)/nMW;
y = (y_react + y_burn)/2;

Q = q_estimate/(cp_ini*T_ini);

%% Detonation Zone
V_det = (0:.01:1.25);
P_det0 = zeros(1,length(V_det));
P_det = zeros(1,length(V_det));
Pcj_det = zeros(1,length(V_det));
P_ray = zeros(1,length(V_det));

% Chapman Jouguet Detonation Case Rayleigh Line
Mcj_det = sqrt(Q*(y+1) + 1 + sqrt(((y+1)*Q + 1)^2 - 1));

% Rayleigh Line for specified speed of propagation
speed = 3500; %m/s
C = 343; %m/s
M = speed/C;

for i = 1:length(V_det)
    P_det0(i) = (-V_det(i) + (y+1)/(y-1))/(((y+1)/(y-1))*V_det(i) - 1);
    P_det(i) = ((2*y*Q)/(y-1) - V_det(i) + (y+1)/(y-1))/((y+1)*V_det(i)/(y-1) - 1);
    Pcj_det(i) = y*Mcj_det^2*(1 - V_det(i)) + 1;
    P_ray(i) = y*M^2*(1 - V_det(i)) + 1;
end

% Finding CJ Point for Detonation
CJ_det = find(abs(P_det-Pcj_det) < 0.1);
CJ_dety = sum(P_det(CJ_det))/length(CJ_det);
CJ_detx = V_det(round(mean(CJ_det)))-.005; % .005 is adjusting factor to fit marker on plot due to rounding

% Finding von Neumann point
vN = find(abs(P_det0-Pcj_det) < 0.1);
vNy = mean(Pcj_det(vN((vN < 100))));
vNx = V_det(round(mean(vN((vN < 100)))));

% Finding Constant Volume point
ConV = P_det(V_det() == 1);

% Plot Detonation
figure(1)
grid on
hold on

ylim([0 80]);
xlim([0 1.25]);

% Plot Forbidden Zones
patch([1 1 50 50],[1 200 200 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')

plot(V_det(13:126),P_det0(13:126),'b') % Plot for Q = 0
plot(V_det(13:100),P_det(13:100),'r',V_det(101:end),P_det(101:end),'r--') % Plot for solved Q with forbidden zone dashed
plot(V_det,Pcj_det,'k') % Plot M slope for solved
plot(V_det,P_ray,'k--') % Plot M slope for 3400 m/s wave

plot(CJ_detx,CJ_dety,'.','MarkerSize',20,'Color','black'); % Marker for CJ Solution
plot(vNx,vNy,'.','MarkerSize',20,'Color','black'); % Marker for von Neuman Point
plot(1,ConV,'.','MarkerSize',20,'Color','black'); % Marker for Constant Volume

alpha(0.3)

% Add Text
text(.2,20,'Q = 0 (Inert Shock)','Color','blue')
text(.42,53,'Q = 13.18','Color','red','FontSize',10)
text(.2,48,'M = 7.85','Color','black')
text(.3,35,'CJ Detonation','Color','black')
text(.5,70,'CJ Detonation at 3500 m/s','Color','black')
text(.55,67,'M = 10.2041','Color','black')
text(.1,73,'von Neuman Point','Color','black','FontSize',8)
set(text(1.02,20,'Constant Volume Equation Point','Color','black'),'Rotation',90)

% Labels
xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Detonation Case of Hugoniot Curves (CO + 1/2 O_2) Perfect Gas')

hold off



%% Deflagaration Zone
V_flag = (1:.1:30);
P_flagO = zeros(1,length(V_flag));
P_flag = zeros(1,length(V_flag));
Pcj_flag = zeros(1,length(V_flag));

Mcj_flag = sqrt(Q*(y+1) + 1 - sqrt(((y+1)*Q + 1)^2 - 1));

for i = 1:length(V_flag)
    P_flagO(i) = (-V_flag(i) + (y+1)/(y-1))/(((y+1)/(y-1))*V_flag(i) - 1);
    P_flag(i) = ((2*y*Q)/(y-1) - V_flag(i) + (y+1)/(y-1))/((y+1)*V_flag(i)/(y-1) - 1);
    Pcj_flag(i) = y*Mcj_flag^2*(1 - V_flag(i)) + 1;
end

% Finding CJ Point for Deflagaration
CJ_flag = find(abs(P_flag-Pcj_flag) < 0.00001);
CJ_flagy = sum(P_flag(CJ_flag))/length(CJ_flag);
CJ_flagx = V_flag(round(mean(CJ_flag)))-.005; % .005 is adjusting factor to fit marker on plot due to rounding


% Split Q line into forbidden and not forbidden for clarity
Forb_flag = (P_flag >= 1);

top_flag = P_flag;
bot_flag = P_flag;

bot_flag(Forb_flag) = NaN;
top_flag(~Forb_flag) = NaN;

figure(2)
grid on
hold on
ylim([0 1.25]);
xlim([0 30])

% Shade forbidden regions
patch([1 1 50 50],[1 50 50 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')


plot(V_flag,P_flagO,'b') % Plot Q = 0
plot(V_flag,Pcj_flag,'k') % Plot M Slope
plot(V_flag,bot_flag,'r',V_flag,top_flag,'r--') %Plot Solved Q, dashed for forbidden zone
plot(V_flag(133),1,'.','MarkerSize',20,'Color','black'); % Marker for constant point
plot(CJ_flagx,CJ_flagy,'.','MarkerSize',20,'Color','black'); % Marker for CJ Solution

alpha(0.3)

% Add Text
text(1.8,.67,'Q = 0 (Expansion Shock)','Color','blue')
text(5,.95,'M = 0.1274','Color','black')
text(17.4,.85,'Q = 13.18','Color','red')
text(14.5,1.05,'Constant Pressure Equation Point','Color','red')
text(20.5,.45,'CJ Deflagaration','Color','black')

xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Deflagaration Case of Hugoniot Curves (CO + 1/2 O_2) Perfect Gas')

hold off

%% Part 2

% CEA Results
Pcea = 18.497;
Mcj = 5.2354;
Pcj = zeros(1,length(V_det));

y_cea = 1.3977;

for i = 1:length(V_det)
    Pcj(i) = y_cea*Mcj^2*(1 - V_det(i)) + 1;
end



% From CEA Inert Shock
M_frozen = [0.9981 1.5686 2.1496 2.7305 3.3115 3.8924 4.4734 5.0253 5.6063 6.1872 6.7682 7.3491 7.9301 8.5111 9.0920 9.6730 10.2539 10.8349 11.4159 11.6192];
P_frozen = [1.011 2.707 5.246 8.602 12.792 17.824 23.699 30.061 37.58 45.942 55.147 65.197 76.093 87.834 100.422 113.857 128.14 143.272 159.256 165.053];
V_frozen = 1./[1.0028 1.9861 2.9196 3.6988 4.3391 4.8686 5.3104 5.6639 5.9804 6.251 6.4850 6.6896 6.8703 7.0313 7.1758 7.3066 7.4256 7.5350 7.6367 7.671];


% Equilibrium Calculation CEA
M_eq = [5.2354 5.3739 5.5191 5.6644 5.8096 5.9548 6.1001 6.2453 6.3906 6.5358 6.9715 7.5525 8.1334 8.7144];
P_eq = [18.497 23.726 26.85 29.652 32.33 34.959 37.571 40.189 42.825 45.487 53.677 65.188 77.453 90.514];
V_eq = 1./[1.8406 2.2944 2.5507 2.7745 2.9826 3.1815 3.3744 3.5627 3.7476 3.9296 4.4609 5.1407 5.7875 6.398];

Vcea = V_eq(1);

% Plot
figure(3)
grid on
hold on

h = zeros(1,3);

ylim([0 80]);
xlim([0 1.25]);

% Plot Forbidden Zones
patch([1 1 50 50],[1 200 200 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')

plot(V_det,Pcj,'k')
h(1) = plot(V_frozen, P_frozen, 'b-.','DisplayName','Inert Shock');
h(2) = plot(V_eq, P_eq, 'r-.','DisplayName','Strong Detonation');

h(3) = plot(Vweak,Pweak,'m','DisplayName','Weak Detonation');

plot(Vcea,Pcea,'.','MarkerSize',20,'Color','black'); % Marker for CJ Solution
plot(1,9.45531,'.','MarkerSize',20,'Color','black'); % Marker for Constant Volume Solution from CEA

alpha(0.3)

% Add Text
text(Vcea,23,'CJ Solution','Color','black')
text(.55,7,'M = 5.2354','Color','black')
set(text(1.02,10,'Constant Volume Equation Point','Color','black'),'Rotation',90)
text(.17,35,'von Neuman Point','Color','black','FontSize',8)

plot(.1733,32.67,'.','MarkerSize',20,'Color','black'); % Marker for von Neuman Point Equilibrium From Graph

% Labels
xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Detonation Case of Hugoniot Curves (CO + 1/2 O_2)')
legend(h);

hold off

% Overlay/Compare Graphs
figure(4)
grid on
hold on

h1 = zeros(1,2);

ylim([0 80]);
xlim([0 1.25]);

% Plot Forbidden Zones
patch([1 1 50 50],[1 200 200 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')

% Perfect Gas
plot(V_det(13:100),P_det(13:100),'r',V_det(101:end),P_det(101:end),'r--') % Plot for solved Q with forbidden zone dashed
h1(1) = plot(V_det,Pcj_det,'k','DisplayName','Perfect Gas'); % Plot M slope for solved
plot(V_det(13:126),P_det0(13:126),'b')

% Equilibrium
h1(2) = plot(V_det,Pcj,'k-.','DisplayName','Equilibrium Solution');
plot(V_frozen, P_frozen, 'b-.')
plot(V_eq, P_eq, 'r-.')
plot(Vweak,Pweak,'m-.');

%Constant Volume Solutions
plot(1,9.45531,'.','MarkerSize',20,'Color','black'); % Equilibrium
plot(1,ConV,'.','MarkerSize',20,'Color','black'); % Perfect

plot(Vcea,Pcea,'.','MarkerSize',20,'Color','black');
plot(CJ_detx,CJ_dety,'.','MarkerSize',20,'Color','black');

plot(vNx,vNy,'.','MarkerSize',20,'Color','black'); % Marker for von Neuman Point Perfect
plot(.1733,32.67,'.','MarkerSize',20,'Color','black'); % Marker for von Neuman Point Equilibrium From Graph

alpha(0.3)

% Add Text
legend(h1(1:2));
text(1.02,10,'CV Equilibrium','Color','black','FontSize',8)
text(1.02,20,'CV Perfect Gas','Color','black','FontSize',8)

text(.29,19,'M = 5.2354','Color','black')
text(.6,35,'M = 7.85','Color','black')

text(.15,70,'von Neuman Point','Color','black','FontSize',8)
text(.17,35,'von Neuman Point','Color','black','FontSize',8)

% Labels
xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Equilibrium vs Perfect Gas Assumption Detonation Region')

hold off

% Compare Deflagaration
figure(5)
grid on
hold on
ylim([0 1.25]);
xlim([0 30])

% Shade forbidden regions
patch([1 1 50 50],[1 50 50 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')


plot(V_flag,P_flagO,'b') % Plot Q = 0
plot(V_flag,Pcj_flag,'k') % Plot M Slope
plot(V_flag,bot_flag,'r',V_flag,top_flag,'r--') %Plot Solved Q, dashed for forbidden zone
plot(V_flag(133),1,'.','MarkerSize',20,'Color','black'); % Marker for constant point
plot(CJ_flagx,CJ_flagy,'.','MarkerSize',20,'Color','black'); % Marker for CJ Solution
plot(9.9892,1,'.','MarkerSize',20,'Color','black'); % Constant Volume Equilibrium (T_2/T_1) from CEA

alpha(0.3)

% Add Text
text(1.8,.67,'Q = 0 (Expansion Shock)','Color','blue')
text(2,.85,'M = 0.1274','Color','black')
text(17.4,.85,'Q = 13.18','Color','red')
text(14.5,1.05,'Perfect Gas Constant P','Color','red')
text(20.5,.45,'CJ Deflagaration','Color','black')
text(3,1.05,'Equilibrium Constant P','Color','black')


xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Equilibrium vs Perfect Gas Assumption Deflagaration Region')

hold off



%% Table Of CJ Properties
MT = [Mcj_det*C;Mcj*C];
PT = [CJ_dety;Pcea];
DT = [1.7699;1.8406];
TT = [11.826;5.657];

varRow = {'Perfect Gas','Equilibrium'};
varName = {'Velocity (m/s)','Pressure Ratio','Density Ratio','Temperature Ratio'};

Table1 = table(MT,PT,DT,TT,'VariableNames',varName,'RowNames',varRow)

%% Plotting Isentrope
P1 = 1; %atm
T1 = 298; %K
M1 = 29.34; %1/n

s =[
   9.2409E+00  3.2977E+03  3.5605E+01;
   1.0106E+01  3.3207E+03  3.5517E+01;
   1.0980E+01  3.3423E+03  3.5434E+01;
   1.1861E+01  3.3627E+03  3.5358E+01;
   1.2750E+01  3.3820E+03  3.5286E+01;
   1.3647E+01  3.4003E+03  3.5218E+01;
   1.4550E+01  3.4177E+03  3.5154E+01;
   1.5460E+01  3.4344E+03  3.5094E+01;
   1.6376E+01  3.4504E+03  3.5036E+01;
   1.7299E+01  3.4657E+03  3.4982E+01;
   1.8227E+01  3.4805E+03  3.4929E+01;
   1.9161E+01  3.4947E+03  3.4879E+01;
   2.0100E+01  3.5084E+03  3.4831E+01;
   2.1044E+01  3.5217E+03  3.4785E+01;
   2.1994E+01  3.5345E+03  3.4741E+01;
   2.2948E+01  3.5470E+03  3.4698E+01;
   2.3908E+01  3.5591E+03  3.4657E+01;
   2.4872E+01  3.5708E+03  3.4617E+01;
   2.5840E+01  3.5822E+03  3.4579E+01;
   2.6813E+01  3.5933E+03  3.4542E+01;
   2.7791E+01  3.6042E+03  3.4506E+01;
   2.8772E+01  3.6147E+03  3.4471E+01;
   2.9758E+01  3.6250E+03  3.4437E+01;
   3.0748E+01  3.6351E+03  3.4404E+01;
   3.1741E+01  3.6449E+03  3.4372E+01;
   3.2739E+01  3.6546E+03  3.4341E+01;
   3.3740E+01  3.6640E+03  3.4310E+01;
   3.4745E+01  3.6732E+03  3.4281E+01;
   3.5754E+01  3.6822E+03  3.4252E+01;
   3.6766E+01  3.6911E+03  3.4224E+01;
   3.7782E+01  3.6998E+03  3.4196E+01;
   3.8801E+01  3.7083E+03  3.4169E+01;
   3.9824E+01  3.7167E+03  3.4143E+01;
   4.0850E+01  3.7249E+03  3.4117E+01;
   4.1879E+01  3.7329E+03  3.4092E+01;
   4.2911E+01  3.7409E+03  3.4067E+01;
   4.3946E+01  3.7487E+03  3.4043E+01;
   4.4985E+01  3.7563E+03  3.4020E+01;
   4.6027E+01  3.7639E+03  3.3996E+01;
   4.7071E+01  3.7713E+03  3.3974E+01;
   4.8119E+01  3.7786E+03  3.3951E+01;
   4.9169E+01  3.7858E+03  3.3930E+01;
   5.0223E+01  3.7929E+03  3.3908E+01;
   5.1279E+01  3.7999E+03  3.3887E+01;
   5.2338E+01  3.8068E+03  3.3866E+01;
   5.6602E+01  3.8335E+03  3.3787E+01;
   5.7674E+01  3.8399E+03  3.3768E+01;
   5.8749E+01  3.8463E+03  3.3749E+01;
   5.9827E+01  3.8525E+03  3.3731E+01;
   6.0907E+01  3.8587E+03  3.3713E+01;
   6.1990E+01  3.8649E+03  3.3695E+01;
   6.3075E+01  3.8709E+03  3.3677E+01;
   6.4163E+01  3.8769E+03  3.3660E+01;
   6.5253E+01  3.8828E+03  3.3643E+01;
   6.6345E+01  3.8886E+03  3.3626E+01;
   6.7440E+01  3.8944E+03  3.3609E+01;
   6.8537E+01  3.9001E+03  3.3593E+01;
   6.9636E+01  3.9058E+03  3.3577E+01;
   7.0738E+01  3.9114E+03  3.3561E+01;
   7.1842E+01  3.9169E+03  3.3545E+01;
   7.2948E+01  3.9224E+03  3.3530E+01;
   7.4057E+01  3.9278E+03  3.3514E+01;
   7.5167E+01  3.9331E+03  3.3499E+01;
   8.1876E+01  3.9642E+03  3.3413E+01;
   8.3002E+01  3.9692E+03  3.3399E+01;
   8.4129E+01  3.9741E+03  3.3385E+01;
   8.5259E+01  3.9791E+03  3.3371E+01;
   8.6390E+01  3.9839E+03  3.3358E+01;
   8.7524E+01  3.9887E+03  3.3345E+01;
   8.8660E+01  3.9935E+03  3.3332E+01;
   8.9797E+01  3.9983E+03  3.3319E+01;
   9.0936E+01  4.0030E+03  3.3306E+01;
   9.2078E+01  4.0076E+03  3.3293E+01;
   9.3221E+01  4.0122E+03  3.3281E+01;
   9.4366E+01  4.0168E+03  3.3268E+01;
   9.5513E+01  4.0214E+03  3.3256E+01;
   9.6662E+01  4.0259E+03  3.3244E+01;
   9.7813E+01  4.0304E+03  3.3232E+01;
   9.8965E+01  4.0348E+03  3.3220E+01;
   1.0012E+02  4.0392E+03  3.3208E+01;
   1.0128E+02  4.0436E+03  3.3197E+01;
   1.0243E+02  4.0479E+03  3.3185E+01;
   1.0359E+02  4.0522E+03  3.3174E+01;
   1.0476E+02  4.0565E+03  3.3162E+01]; %P2 T2 M2

Vs = zeros(1,length(s));
Ps = zeros(1,length(s));

for i = 1:length(s)
   Vs(i) = (P1*s(i,2)*M1)/(s(i,1)*T1*s(i,3));
   Ps(i) = s(i,1)/P1;
end

% Overlay/Compare Graphs
figure(6)
grid on
hold on

h2 = zeros(1,4);

ylim([0 80]);
xlim([0 1.25]);

% Plot Forbidden Zones
patch([1 1 50 50],[1 200 200 1], 'b')
patch([0 0 1 1],[0 1 1 0], 'b')


% Equilibrium
h2(1) = plot(V_det,Pcj,'k-.','DisplayName','Rayleigh Line');
h2(2) = plot(V_frozen, P_frozen, 'b-.','DisplayName','Inert Shock');
h2(3) = plot(V_eq, P_eq, 'r-.','DisplayName','Equilibrium Solution');
h2(4) = plot(Vs,Ps,'g','DisplayName','Isentropic Curve');

%Constant Volume Solutions
plot(1,9.45531,'.','MarkerSize',20,'Color','black'); % Equilibrium
plot(Vcea,Pcea,'.','MarkerSize',20,'Color','black');
plot(.1733,32.67,'.','MarkerSize',20,'Color','black'); % Marker for von Neuman Point Equilibrium From Graph

plot(Vweak,Pweak,'m-.');

alpha(0.3)

% Add Text
text(1.02,10,'CV Equilibrium','Color','black','FontSize',8)
text(.29,19,'M = 5.2354','Color','black')
text(.17,35,'von Neuman Point','Color','black','FontSize',8)

legend(h2)

% Labels
xlabel('v_2/v_1')
ylabel('p_2/p_1')
title('Equilibrium Gas Assumption Detonation Region with Isentrope')

hold off
