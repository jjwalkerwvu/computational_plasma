%% Jeffrey J. Walker
%% CPP 782

%% walker_relax_input.m allows for a user to edit the input matrix for the
%% relaxation algorithm.

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%  Basic parameters of the square computational mesh:

L=0.5;      %% length of the box
n=200;      %% number of x and y cells

n_rect;     %% number of "filled" rectangles


%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% Don't touch this part of the code!
%% now set up coordinate system.
x=linspace(0,L,n);
y=linspace(0,L,n);
V=zeros(n);
%% mask matrix, which is used to preserve bcs inside the computational volume.
%% this will be updated later, but for now just initializing it so that it's 
%% the same size as V.
mask=V;