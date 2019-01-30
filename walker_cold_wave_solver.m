%% Jeffrey J. Walker, September 5, 2012
%% CPP 782
%% 
%% This is a simple program for finding (and then plotting) the normalized phase speed as a 
%% function of propagation angle, theta. It (should) correctly label the fast and slow wave
%% solutions on the outputted plot.

%% inputs for this function: 
%
% B - magnetic field in Tesla
% n0 - background density in m^-3
% wave_freq - the driving frequency, in hz
% species - an optional parameter to allow for different masses of ion 
% species. Choose 1 for proton-electron plasma.
function [ux_fast,uz_fast,ux_slow,uz_slow,theta_fast,theta_slow] = walker_cold_wave_solver(B,n0,wave_freq,species);
% Brief description of inputs: B is the magnetic field in Tesla, n0 is the background density in m^-3,
% the wave_freq is the user input frequency in hertz (NOT THE ANGULAR FREQENCY) and species
% is an optional paramter for inputting different species.


% number of points to plot. 10000 seems to work alright, but add more if
% you'd like.
n_points=10000;
if wave_freq==0
	exception = '*sigh*, you should not have put in 0 for the wave frequency';
    	error(exception)
end

if B==0
  	exception = '*sigh*, you should not have put in 0 for the magnetic field';
    	error(exception)
end

if n0==0
    	exception = '*sigh*, you should not have put in 0 for the background density';
    	error(exception)
end
me=9.1e-31;
mp=1.67e-27;
qe=1.6e-19;
eps0=8.854e-12;
c=3e8;
%species = 40; %% the mass of a singly ionized Argon population
mi=mp*species;
mu = mi/me;

% propagation angle relative to the magnetic field (B is along +z.) Theta is in radians
theta=[0:2*pi/n_points:2*pi-pi/n_points];  


% Compute alpha, beta, gamma based on the user inputs:
alpha = (qe^2*n0/eps0/mi/wave_freq^2/4/pi^2);
beta = qe*B/mi/wave_freq/2/pi;
gamma = alpha/mu/beta^2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%~~~# for the first part of the hw problem
% beta=1000;
% gamma=1000;
% alpha = mu*gamma*beta^2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%~~~# for the second part of the hw problem
% beta=1.1;
% gamma=1000;
% alpha = mu*gamma*beta^2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%~~~# LOWER HYBRID WAVES example
%beta = 4.2e-3
%gamma =3e8;
%alpha = mu*gamma*beta^2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%~~~# ALFVEN WAVES example
%beta = 1e3;
%gamma = 1e3;
%alpha = mu*gamma*beta^2;
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
R = 1 - (gamma*beta^2)/(beta+1) + (gamma*beta^2)/(beta-1/mu);
L = 1 + (gamma*beta^2)/(beta-1) - (gamma*beta^2)/(beta+1/mu);
P = 1 - gamma*beta^2 - gamma*mu*beta^2;

S = .5*(R+L);
D = .5*(R-L);

A = S*(sin(theta)).^2 + P*(cos(theta)).^2;
B = R.*L.*(sin(theta)).^2 + P.*S.*(1+(cos(theta)).^2);
C = P*R*L;  %% hope to have a prl someday
if C==0
	exception = 'Sorry, you picked some weird values and got C=0. I did not know this could even happen.';
    	error(exception)
end

%% check the discriminant.
discrim = B.^2 - 4*A.*C;
%% if there are any negative values for the discriminant, then an 
%% imaginary solution will result
dflag = min(discrim)<0; 	% if dflag=1, there's a problem.
if dflag==1
	exception = 'Sorry, but you input some numbers that resulted in imaginary solutions.'
	error(exception)
end


%% solutions for U^2:
u_squared_plus = B./C/2+sqrt(B.^2 - 4*A.*C)./C/2; 
u_squared_minus = B./C/2-sqrt(B.^2 - 4*A.*C)./C/2;

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% There is probably a better way to make sure the fast and slow wave
%% solutions are labelled correctly, but this is what I came up with.

%% remove junk indices. At angles 90 and 270 (incidentally, where tan theta
%% blows up) I get very small but negative values for u^2. This is probably
%% due to rounding errors. Also, this assures that I will only get positive
%% definite values of the normalized phase velocity.
ind_rem1 = find(u_squared_plus<0);
ind_rem2 = find(u_squared_minus<0);
u_squared_plus(ind_rem1)=[];
u_squared_minus(ind_rem2)=[];
%% initialize these variables now; they'll be used slightly later
theta_fast=theta;
theta_slow=theta;
%% don't need theta anymore, or A,B,C, and discrim from earlier.
clear theta;clear A;clear B;clear C;clear discrim;

%% see which vector is bigger. Already discarded negative entries, so if either +u^2 or -u^2
%% solutions had purely negative solutions, they'll have a norm of zero, and have zero entries.
%% This situation would arise for a non-propagating wave.
up_norm =norm(u_squared_plus);
um_norm=norm(u_squared_minus);

%% case1 applies when the norm of +u^2 is greater than the norm of -u^2 and the -u^2
%% solution exists
case1=up_norm>um_norm && length(u_squared_minus)>0;
%% case1 applies when the norm of +u^2 is greater than the norm of -u^2 and the -u^2
%% solution does not exist
case2=up_norm>um_norm && length(u_squared_minus)==0;
%% case 3 applies when the norm of +u^2 is less than the norm of -u^2 and the +u^2
%% solution exists
case3=up_norm<um_norm && length(u_squared_plus)>0;
%% case 3 applies when the norm of +u^2 is less than the norm of -u^2 and the +u^2
%% solution does not exist
case4=up_norm<um_norm && length(u_squared_plus)==0;


%% applies whenever +u^2 is bigger than -u^2, and so the "plus" solution of
%% u^2 is the fast solution
if up_norm>um_norm
	
	u_fast = u_squared_plus;
	u_slow = u_squared_minus;
	theta_fast(ind_rem1)=[];
	theta_slow(ind_rem2)=[];
	ux_fast =sqrt(u_fast).*sin(theta_fast);
	uz_fast =sqrt(u_fast).*cos(theta_fast);
	ux_slow =sqrt(u_slow).*sin(theta_slow);
	uz_slow =sqrt(u_slow).*cos(theta_slow);
    %% if there is no solution at all for the "minus" solution of u^2,
    %% I return zero because matlab doesn't like dealing with empty arrays
    %% for some reason.
	if up_norm>um_norm && length(u_squared_minus)==0
		u_slow(1)=0;
		theta_slow(1)=0;
		ux_slow =sqrt(u_slow).*sin(theta_slow);
		uz_slow =sqrt(u_slow).*cos(theta_slow);
    end
    
	clf;figure(1);plot(ux_fast,uz_fast,'--r','LineWidth',2);hold on;plot(ux_slow,uz_slow,'g','LineWidth',2);
    set(gca,'fontsize',16);
	legend('fast mode','slow mode')
    xlabel('Normalized U_x phase velocity')
    ylabel('Normalized U_z phase velocity')
    title('Normalized Phase Velocity as Function of Propagation Angle')

%% applies when +u^2 is smaller than -u^2, and so the "minus" u^2 solution
%% is the fast mode
else if up_norm<um_norm
	u_fast = u_squared_minus; 
	u_slow = u_squared_plus;
	theta_fast(ind_rem2)=[];
	theta_slow(ind_rem1)=[];
	ux_fast =sqrt(u_fast).*sin(theta_fast);
	uz_fast =sqrt(u_fast).*cos(theta_fast);
	ux_slow =sqrt(u_slow).*sin(theta_slow);
	uz_slow =sqrt(u_slow).*cos(theta_slow);
    %% if there is no solution at all for the "plus" solution of u^2,
    %% I return zero because matlab doesn't like dealing with empty arrays
    %% for some reason.
	if up_norm<um_norm && length(u_squared_plus)==0
		u_slow(1)=0;
		theta_slow(1)=0;
		ux_slow =sqrt(u_slow).*sin(theta_slow);
		uz_slow =sqrt(u_slow).*cos(theta_slow);
	end
	
	clf;figure(1);plot(ux_fast,uz_fast,'--r','LineWidth',2);hold on;plot(ux_slow,uz_slow,'g','LineWidth',2);
    set(gca,'fontsize',16);
	legend('fast mode','slow mode')
    xlabel('Normalized U_x phase velocity')
    ylabel('Normalized U_z phase velocity')
    title('Normalized Phase Velocity as Function of Propagation Angle')
	
end





end

