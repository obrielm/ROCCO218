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
A = [a, b; -c, d];
B = [e; f];
C = [1 0];
D = 0;
%--------------------------------------------------------------
PX1 = 8 * [-1 -1.1];
GAIN_K = place(A,B,PX1);
%GAIN_KT = GAIN_K;
%--------------------------------------------------------------
PX2 = 20 * [-1 -1.2];
L = place(A,C',PX2);

%--------------------------------------------------------------
timeStep = 0.02;    % time steps for integration

totalTime = 0.98;      % total time for simulation

tspan = 0:timeStep:totalTime;   % build timepoint vector

%--------------------------------------------------------------
titleMessage = 'uncontrolled nonlinear sim of FC pendulum on cart';
disp(titleMessage)

%--------------------------------------------------------------
x0 = [0; 2;];       % model introduces slight amount of noise so it will not stay balanced.

[y, t, X_OUT] = OBSERVER_T7(A, B, C, D, GAIN_K, L, tspan, x0);
%--------------------------------------------------------------
% for all time point animate the results
range=1;
len = length(tspan);
kickFlag = zeros(1,len);
%--------------------------------------------------------------
% get variables
x = y(1, :) * 0;    % cart positon
%th = y(:, 1);
%--------------------------------------------------------------
thet = y(1, :);

TASK = 'TASK-7';

%th = transpose(the);   % pendulum angle
%--------------------------------------------------------------
% animate pendulum



figure
AnimatePendulumCart(thet + pi,  x, L/2, tspan, range, kickFlag, TASK);

figure
hold on
plot(t,y)
