% Summary of the parameters
m = 0.314;  %   mass of the pendulum
L = 0.64;   %   Length of the rod
d = 0.05;   %   coefficient of viscous friction
g = 9.81;   %   acceleration by gravity
mu = 0.05;  %   coefficient of viscous friction

% Simplified terms
I = (m*L^2)/12;
G = (I + m*L^2); %   The matrix denominator

% The matrix values
a = 0;
b = 1;
c = (m*g*L)/G;
d = -mu/G;

e = m*L/G;
f = (-mu*m*L)/G^2;

% The matrices
A = [a, b; c, d];
B = [e; f];
%-------------------------------------------------------------------
PX = 8 *[-1 -1.1];
GAIN_K = place(A,B,PX);
%GAIN_K;

%-------------------------------------------------------------------
timeStep = 0.02; % time steps of 100ms for integration

totalTime = 3; % total time for simulation

tspan = 0:timeStep:totalTime;   % build timepoint vector

%-------------------------------------------------------------------
y0 = [0; 2];
[t,y] = ode45(@(t,y)TASK_5_FUNC(A, y, B, -GAIN_K*y),tspan,y0);
%-------------------------------------------------------------------
% for all time point animate the results
range=1;
len = length(tspan);
kickFlag = zeros(1,len);
%-------------------------------------------------------------------
% get variables
x = y(:, 1)*0;    % cart positon
th = y(:, 1);     % pendulum angle
%-------------------------------------------------------------------
% animate pendulum
figure
AnimatePendulumCart(pi+th,  x, L/2, tspan, range, kickFlag, "OBRIEL");

figure
hold on
plot(t,y(:,1))

