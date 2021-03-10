function [Vweak,Pweak] = weak()
    CEAweak = [
   1.1146E+01  1.3198;
   1.2666E+01  1.4998;
   1.4185E+01  1.6798;
   1.5705E+01  1.8597;
   1.7225E+01  2.0397;
   1.8745E+01  2.2197]; % P rho
   
   
   
   
    P1 = 1; %atm
    T1 = 298; %K
    M1 = 29.34; %1/n
    D1 = 1.199826;
    
    Vweak = zeros(1,length(CEAweak)+1);
    Pweak = zeros(1,length(CEAweak)+1);

    Vweak(1) = 1;
    Vweak(2:end) = D1./CEAweak(:,2);
    
    Pweak(1) = 9.45531;
        
    for i = 1:length(CEAweak)
       Pweak(i+1) = CEAweak(i,1)*(0.986923)/P1;
    end
    
end