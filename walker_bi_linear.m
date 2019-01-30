%% Jeffrey J. Walker, October 7, 2012
%% CPP 782
%% 
%% This is a simple function for doing a bi-linear interpolation to
%% "spread" a point charge onto the neighboring grid points, weighted by
%% the distance to each of the 4 nodes.

%% inputs for this function: 
%
% xp is the x-coordinate of the charge
% yp is the y-coordinate of the charge
% q is the value of the charge; this can allow for superparticles etc.
% ds is the grid size (square gridding, so dx=dy=ds)

function [Q] = walker_bi_linear(xp,yp,q,Q,ds);

i=floor(xp/ds)+1;   %% need to add one for matlab; this is the "leftmost"
                    %% grid point coordinate

j=floor(yp/ds)+1;   %% need to add one for matlab; this is the "bottom-most"
                    %% grid point coordinate

%% calculate the areas:

%% area of the bottom left corner
a_bl=mod(xp,ds)*mod(yp,ds);
%% area of the bottom right corner
a_br=mod((i)*ds-xp,ds)*mod(yp,ds);
%% area of the top right corner
a_tr=mod((i)*ds-xp,ds)*mod((j)*ds-yp,ds);
%% area of the top left corner
a_tl=mod(xp,ds)*mod((j)*ds-yp,ds);

%% now it's a simple matter of weighting the charge, adding to the charge
%% that is already on the node
Q(i,j)=Q(i,j)+q*a_tr/ds/ds;
Q(i,j+1)=Q(i,j+1)+q*a_br/ds/ds;
Q(i+1,j)=Q(i+1,j)+q*a_tl/ds/ds;
Q(i+1,j+1)=Q(i+1,j+1)+q*a_bl/ds/ds;


end

