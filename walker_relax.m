%% Jeffrey J. Walker
%% CPP 782

%% This is the main algorithm for the relaxation method. The problem geometry 
%% must be used as an input for this function
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% Inputs:
%%

%%  x = the x-coordinate, input from gui or text file
%%  y = the y-coordinate, input from gui or text file
%%  V = the input matrix for the voltage; this serves as the initial guess for V
%%  M = the mask matrix, which has all of the boundary conditions. This is 
%%  computed in the front-end, walker_relax_frontend.m

%%	update_limit = if the update in voltage is less than this limit, stop the 
%%  algorithm
%%	w = the overrelaxation parameter. Choose: 0<w<2, 0<w<1 is underrelaxation


function [x,y,V]= walker_relax(x,y,V,M,update_limit,w);

%%  V should be a 2d array that is of size: (x-dimension)*(y-dimension). As 
%%  an input, V will mostly be a sparse array but it will contain all the BCs 
%%  of the problem

%% figure out the sizes of the arrays
[irrelevant,x_size]=size(x);
[irrelevant,y_size]=size(y);

%% completely irrelevant variable that I don't need.
irrelevant=0;

%% Build a mask out of the surfaces placed in the 2D box. This "reminds" the 
%% algorithm that coordinates where V != 0 initially should not be changed.

%mask=V;     %% I had intended to make an array filled with ones but this works
            %% too.

%% error handling:
%if sign(domain)<0
	%exception = 'YOU MUST USE A POSITIVE DEFINITE VALUE FOR THE DOMAIN!!!';
	%error(exception)
%end


%% the main loop:
V_est=V;
Vold=V;
tol=max(max(V_est));
V_est_comp=0;
k=1;
while(tol>update_limit)
	
	for i=2:x_size-1
		for j=2:y_size-1
    %% use the mask that was built earlier to see if we encounter a boundary 
    %% in V(i,j). We want to avoid overwriting cells that correspond to BCs.
            if M(i,j) ~= 0
                Vold=V(i,j);
            else
                Vold=V(i,j);
                V_est=(0.25)*(V(i+1,j)+V(i-1,j)+V(i,j+1)+V(i,j-1));
                V(i,j)=(1-w)*V(i,j)+w*V_est;
            end
	%% this little if statement assures that I always have the maximum value for the
	%% voltage update.
			if abs(V(i,j)-Vold)>V_est_comp;
				V_est_comp=abs(V(i,j)-Vold);
			end	
        end
	end
	%% check to see if the maximum update is below the user-imposed limit
	tol = max(max(V_est_comp));
	%% reset for the next time around, so that we only compare V_est for each time through
	%% the main loop.
	V_est_comp=0;
	k=k+1;
	drawnow;surf(x,y,V);set(gca,'fontsize',16);xlabel('x-coord');ylabel('y-coord')
end

end