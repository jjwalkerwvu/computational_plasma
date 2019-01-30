%% Jeffrey J. Walker, October 7, 2012
%% CPP 782
%% 
%% This is just a script which would be representative of how
%% walker_bi_linear is called as a subroutine from the main program.

%% This script also reproduces the answers for problem 1 of HW #5

ds = 2;
q =1;

%% Make a 6x6 array with zeros
Q=zeros(6);

xp=3.7;
yp=5.2;

[Q] = walker_bi_linear(xp,yp,q,Q,ds);

%% show what is the charge at each grid point

disp('Q(1,2) is')
disp(Q(2,3))
disp('Q(1,3) is')
disp(Q(2,4))
disp('Q(2,2) is')
disp(Q(3,3))
disp('Q(2,3) is')
disp(Q(3,4))