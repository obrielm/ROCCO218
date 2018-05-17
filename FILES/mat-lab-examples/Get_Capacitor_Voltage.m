function [ Vc ] = Get_Capacitor_Voltage(R, C, Vs, h)


% got the input sample count
len = length(Vs)-1;

% set the initial value to zero
Vc(1) = 0;

% loop over all the samples -1
for n = 1:len
    
   Vc(n+1) = Vc(n) + h * (1/(R*C)) * (Vs(n) - Vc(n));
    
end
    
end

