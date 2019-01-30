%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%  cpp 782, hw #12, no. 2
%%  
%%  a simple script for reading .txt files.


%% Header looks like:
% XGSM    YGSM   ZGSM    R    BXGSM   BYGSM   BZGSM   B
%  [Re]    [Re]   [Re]   [Re]  [nT]    [nT]   [nT]   [nT]

%fid = fopen('walker_hw12_no1.txt');
%% scan the tab-delimited file into 8 columns.
%A = fscanf(fid,'%f %f %f %f %f %f %f %f',[8,inf])

xgsm=A(1,:);
ygsm=A(2,:);
zgsm=A(3,:);
R=A(4,:);
Bxgsm=A(5,:);
Bygsm=A(6,:);
Bzgsm=A(7,:);
B=A(8,:);
clear A;

%% quick plot to show the field line.
scatter3(xgsm,ygsm,zgsm,2)
set(gca,'fontsize',16);
xlabel('X_{gsm} (R_{E})');
ylabel('Y_{gsm} (R_{E})');
zlabel('Z_{gsm} (R_{E})');

figure(1)
quiver3(xgsm,ygsm,zgsm,Bxgsm,Bygsm,Bzgsm,.5)
set(gca,'fontsize',16);
xlabel('X_{gsm} (R_{E})');
ylabel('Y_{gsm} (R_{E})');
zlabel('Z_{gsm} (R_{E})');
title('Hw #12, no. 1')
