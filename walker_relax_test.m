%% Jeffrey J. Walker
%% CPP 782

%% short script file to test a simple geometry and my overrelaxation algorithm
n=100;	%% number of x elements
m=100;	%% number of y elements
L=0.5;	%% x size of box
H=0.5;	%% y size of box

x=linspace(0,L,n);
y=linspace(0,H,m);


V1=1;	%% voltage set on the x=0 line of the box
V2=5;	%% voltage set on the y=0 line
V3=0;	%% voltage set on the x=L line
V4=0;	%% voltage set on the y=H line

update_limit=0.01;

V=zeros(n,m);
%% the x=0 bc:
V(1,1:m)=V1;
%% the y=0 bc:
V(1:n,1)=V2;
%% the x=L bc:
V(n,1:m)=V3;
%% the y=H bc:
V(1:n,m)=V4;

%% random wire placed in the system:
V(10:n-10,35)=3.5;

%% a little test: let's make a box inside of my 2d grid and see how it changes
%% things:
V(45:50,45:50)=-2.5;

[V]= walker_relax(x,y,V,update_limit,1.5);