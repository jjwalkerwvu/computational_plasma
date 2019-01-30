function [ output_args ] = solver(B,n0,wave_freq,species);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if wave_freq==0
    disp('*sigh*, you should not have put 0 in for the wave frequency')
end

if B==0
    disp('*sigh*, you should not have put 0 in for the magnetic field')
end

if n0==0
    disp('*sigh*, you should not have put 0 in for the background density')
end
me=9.1e-31;
mp=1.67e-27;
qe=1.6e-19;
eps0=8.854e-12;
% propagation angle, theta
species = 40; %% the mass of a singly ionized Argon population
mi=mp*species;
theta=[0:360];  %% using degrees as the units

mu = mi/me;
% Compute alpha, beta, gamma:
alpha = (qe^2*n0/eps0/mi/wave_freq)^2;
beta = qe*B/mi/wave_freq;
gamma = alpha/mu/beta^2;

R = 1 - (gamma*beta^2)/(beta+1) + (gamma*beta^2)/(beta-1/mu);
L = 1 + (gamma*beta^2)/(beta+1) + (gamma*beta^2)/(beta-1/mu);
P = 1 - gamma*beta^2 - gamma*mu*beta^2;

S = .5*(R+L);
D = .5*(R-L);

A = S*(sin(theta)).^2 + P*(cos(theta))^.2;
B = R*L*(sin(theta)).^2 + P*S*(1+(cos(theta)).^2);
C = P*R*L;  %% hope to have a prl someday

%% check the discriminant.
discrim = B.^2 - 4*A.*C;
%% if there are any negative values for the discriminant, then an 
%% imaginary solution will result
dflag = min(discrim)<0; 

%% solutions for U^2:
u_squared_plus = B./(2*A)+sqrt(B.^2 - 4*A.*C); 
u_squared_minus = B./(2*A)-sqrt(B.^2 - 4*A.*C);
%% Test which of these is the fast or slow mode?
end

