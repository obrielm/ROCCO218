% simulate force controlled pendulum on cart using full non-linear model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% all rights reserved
% Author: Dr. Ian Howard
% Associate Professor (Senior Lecturer) in Computational Neuroscience
% Centre for Robotics and Neural Systems
% Plymouth University
% A324 Portland Square
% PL4 8AA
% Plymouth, Devon, UK
% howardlab.com
% 23/01/2018
% Partially based on youTube presentation by Steve Brunton
% https://youtu.be/qjhAAQexzLg
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clean up matlab before launching script
clear all
close all 
clc

% pendulum point mass
m = 1;

% cart mass
M = 2;

% pendulum length
L = 1;

% acceleration due to gravity
g = -10;

% damping
d = 1;

% time steps of 100ms for integration
timeStep = 0.1;
% total time for simulation
totalTime = 30;
% build timepoint vector
tspan = 0:timeStep:totalTime;


titleMessage = 'uncontrolled nonlinear sim of FC pendulum on cart';
disp(titleMessage)


% initial conditions
% located at x=0
% velocity =0
% angle  pi (inverted)
% angular velocity = 0.5 rads-1
y0 = [0; 0; pi; 0.0];

% use ode to solve with FCPendOnCart with no control force input u
% representing a force controlled pendulum on a cart
% model introduces slight amount of noise to wont stay balanced
[t,y] = ode45(@(t,y)FCPendOnCart(y,m,M,L,g,d,0),tspan,y0);

% for all time point animate the results
range=1;
len = length(tspan);
kickFlag = zeros(1,len);

% get variables
x = y(:, 1);    % cart positon
th = y(:, 3);   % pendulum angle

% animate pendulum
figure
AnimatePendulumCart(th,  x, L/2, tspan, range, kickFlag, titleMessage);

