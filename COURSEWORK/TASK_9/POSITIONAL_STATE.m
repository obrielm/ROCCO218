function [y, tspan, X_OUT] = POSITIONAL_STATE(A, B, C, D, GAIN_K, Li, tspan, x0)

%   Simulate State Space Feedback Control using C-language 
%   compatible formulation.
%------------------------------------------------------------
len = length(tspan);    % signal length
%------------------------------------------------------------
y = zeros(1,len);       % init outout
X_OUT = zeros(3,len);
%------------------------------------------------------------

% RECORD initial state

X_OUT(:, 1) = x0;       
x = x0;
X_HAT = x0;

%------------------------------------------------------------
u(1) = C(1) * x(1) + C(2) * x(2);   % calculate the command
%u(1) = C(1) * x(1) + C(2) * x(2) + C(3) * x(3);
%------------------------------------------------------------

% Calculate output from theta and thetaDot states
%y(1) = C(1) * x(1) + C(2) * x(2) + D(1) * u(1);
y(1) = C(1) * x(1) + C(2) * x(2) + C(3) * x(3) + D(1) * u(1);
%------------------------------------------------------------
%Simulate  the SSM using C-Language compatible formulaton

for idx = 2:len
    
    % state feedback role
    
    u(idx) = - GAIN_K(1) * X_HAT(1) - GAIN_K(2) * X_HAT(2) - GAIN_K(3) * X_HAT(3);
    
    % get duration between updates
    
    h = tspan(idx) - tspan(idx-1);
    
    % Calculate state derivative
    
    xdot(1) = A(1,1) * x(1) + A(1,2) * x(2) + B(1) * u(idx);
    xdot(2) = A(2,1) * x(1) + A(2,2) * x(2) + B(2) * u(idx);
    xdot(3) = A(3,1) * x(1) + A(3,2) * x(2) + B(3) * u(idx);
    
    % update the state
    
    x(1) = x(1) + h * xdot(1);
    x(2) = x(2) + h * xdot(2);
    x(3) = x(3) + h * xdot(3);
    
    % record the state
    
   % xout(:, idx) = x;
    
    % calculate output from theta and thetadot states only
    
    y(idx) = C(1) * x(1) + C(2) * x(2) + C(3) * x(3) + D(1) * u(idx);
    
    Y_HAT  = C(1) * X_HAT(1) + C(2) * X_HAT(2) + C(3) * X_HAT(3) + D(1) * u(idx);
%-------------------------------------------------------
    
    Y_CORR = y(idx) - Y_HAT;

    %y_real = C(1) * x(1) + C(2) * x(2) + B(1) * u(idx);
%-------------------------------------------------------   
    X_HAT_DOT(1) = A(1,1) * X_HAT(1) + A(1,2) * X_HAT(2) + B(1) * u(idx) + Li(1) * Y_CORR;
    X_HAT_DOT(2) = A(2,1) * X_HAT(1) + A(2,2) * X_HAT(2) + B(2) * u(idx) + Li(2) * Y_CORR;
%   X_HAT_DOT(3) = A(3,1) * X_HAT(1) + A(3,2) * X_HAT(2) + B(3) * u(idx) + Li(3) * Y_CORR;
    X_HAT_DOT(3) =  B(3) * u(idx);
%-------------------------------------------------------
    % update the state
    
    X_HAT(1) = X_HAT(1) + h * X_HAT_DOT(1);
    X_HAT(2) = X_HAT(2) + h * X_HAT_DOT(2);
    X_HAT(3) = X_HAT(3) + h * X_HAT_DOT(3);
%-------------------------------------------------------  
    
   X_OUT(:, idx) = X_HAT; 
   
end

