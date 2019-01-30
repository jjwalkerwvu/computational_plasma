%% Jeffrey J. Walker
%% CPP 782

%% this is just a short script for plotting my measured values of mode number
%% versus the theoretical prediction from Birdsall and Langdon.

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%  problem 1 of the hw:
%% the plasma frequency (wp) has been set to one for convenience.
wp=1;

ngp=32;         %% the number of grid points used
dx=1/ngp;       %% the grid spacing
mode=[1:1:12];
k=2*pi*mode;

w_theor=wp*cos(k*dx/2);
%% my measured values are input below:
w_meas=wp*[0.994,0.974,0.943,0.901,0.849,0.785,0.748,0.654,0.565,0.507,0.392,0.336];
figure(1);
set(gca,'fontsize',16);
plot(mode,w_theor,'--r','LineWidth',2)
hold on;
plot(mode,w_meas,'-g','LineWidth',2)
legend('\omega(k) = cos(k\Deltax/2)','\omega(k) measured')
xlabel('Mode Number');
ylabel('Mode Frequency');
title('HW #6, problem 1')
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%  problem 2 of the hw:
%%  
%%  I have chosen wc=wp here for simplicity, but this could be done for
%%  wc=a*wp, for any value of a
wc=wp;

w_theor=sqrt(wp^2*(cos(k*dx/2)).^2 + wc^2);
%% my measured values for w(k):
w_meas=wp*[1.41,1.4,1.38,1.36,1.32,1.3,1.26,1.22,1.18,1.14,1.1,1.07];
figure(2);
set(gca,'fontsize',16);
plot(mode,w_theor,'--r','LineWidth',2)
hold on;
plot(mode,w_meas,'-g','LineWidth',2)
legend('\omega(k) = (cos^2(k\Deltax/2) +\omega_c^2)^{1/2}','\omega(k) measured')
xlabel('Mode Number');
ylabel('Mode Frequency');
title('HW #6, problem 2')

