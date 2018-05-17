function [y, tspan, X_OUT] = SFC_INTEGRATION(A, B, C, D, GAIN_K, tspan, x0)

%   Simulate State Space Feedback Control using C-language 
%   compatible formulation.
%------------------------------------------------------------
len = length(tspan);    % signal length
%------------------------------------------------------------
y = zeros(1,len);       % init outout
X_OUT = zeros(2,len);
%------------------------------------------------------------

% RECORD initial state

X_OUT(:, 1) = x0;       
x = x0;
%------------------------------------------------------------
u(1) = C(1) * x(1) + C(2) * x(2);   % calculate the command
%------------------------------------------------------------

% Calculate output from theta and thetaDot states
y(1) = C(1) * x(1) + C(2) * x(2) + D(1) * u(1); 
%------------------------------------------------------------
%Simulate  the SSM using C-Language compatible formulaton

for idx = 2:len
    
    % state feedback role
    
    u(idx) = - GAIN_K(1) * x(1) - GAIN_K(2) * x(2);
    
    % get duration between updates
    
    h = tspan(idx) - tspan(idx-1);
    
    % Calculate state derivative
    
    xdot(1) = A(1,1) * x(1) + A(1,2) * x(2) + B(1) * u(idx);
    xdot(2) = A(2,1) * x(1) + A(2,2) * x(2) + B(2) * u(idx);

    % update the state
    
    x(1) = x(1) + h * xdot(1);
    x(2) = x(2) + h * xdot(2);
    
    % record the state
    
    xout(:, idx) = x;
    
    % calculate output from theta and thetadot states only
    
    y(idx) = C(1) * x(1) + C(2) * x(2) + D(1) * u(idx);

end

