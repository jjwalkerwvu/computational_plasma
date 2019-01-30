%% Jeffrey J. Walker
%% CPP 782, HW #3, problem #3
%% 
%% This is a function which returns a distribution of velocities for a discrete
%% number of particles.

%% This function requires:
%%  - walker_function_list.m
%%  - walker_simpson.m

function [v] = walker_distribution(Npart,int_steps,distribution,vmin,vmax)
%   int_steps = the number of integration steps
%   Npart = the number of particles
%   distribution = a string argument that calls the desired dist. function

%%~~ Step 1: create a distribution
%v = [vmin:(vmax-vmin)/(int_steps):vmax];
v = linspace(vmin,vmax,int_steps);
f_v = walker_function_list(distribution,v);
dv = (vmax-vmin)/int_steps;
%plot(v,f_v);

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%~~ %% alternative method that I tried using first:
for j=1:int_steps
    F = walker_simpson(distribution,int_steps,vmin,vmax);
    if F==0
        exception = 'Division by zero.';
        error(exception)
    end
    %vtest(j)=v(j+1);
    cumulative(j) = walker_simpson(distribution,int_steps,vmin,v(j))/F;

end
plot(v,cumulative);

% %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% %%~~ Step 2: calculate the cummulative distribution in int_steps number of
% %% steps:
% F(1)=0;
% %F(int_steps)=walker_simpson(distribution,int_steps,vmin,vmax);
% F(int_steps)=1;
% for j=2:int_steps-1
%     F(j)=(1/F(int_steps))*(F(j-1)+.5*dv*(f_v(j-1)+f_v(j)));
% end
% clear cumulative;
% cumulative=F;
% plot(v,cumulative);
% disp(cumulative)
% %%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%%~~ Step 3: Create a velocity array for all the particles; i.e., the
%%  matrix is as big as Npart

%% clear v to reuse for the velocities
clear v;
v=zeros(1,Npart);

%%~~ Step 4: 
%%  Binary search algorithm
% left = 1;
% right = int_steps;
%% initialize counter:
%cumulative(17)
for k=1:Npart;
    %left=1;
    left=0;
    right = int_steps;
    while right-left>1
        mid = int16(.5*(right+left));
        %mid = int16(.5*(right-left));
        if cumulative(mid)>(k-1)/(Npart-1)
            right = mid;     
        else
            left = mid;
    
            
        end
    end
    
    if cumulative(left)==cumulative(right);
            disp('here')
        v(k)=0;
    else
        v(k)=vmin+dv*(double(left) + ((k-1)/(Npart-1) - cumulative(left))...
                        /(cumulative(right)-cumulative(left)));
        %v(k)=vmax-dv*(double(left) + (k/Npart - cumulative(left))/(cumulative(right)-cumulative(left)));
    end
    
end

end



