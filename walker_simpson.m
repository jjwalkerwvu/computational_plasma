%% Jeffrey J. Walker
%% CPP 782, HW #3, problem #1
%% 
%% This is a simple program that uses simpson's method to evaluate the integral of
%% a function over a given interval.

%% edit the function: walker_function_list in order to input your function
%% and integration limits. walker_simpson.m takes a string value as its input,
%% which corresponds to a function and integration interval given in 
%% walker_function_list(case_label). Use a string for the integrand variable,
%% which corresponds to:
%%
%% The number of integration steps must be input into walker_simpson, which
%% is Nsteps
function [area]= walker_simpson(integrand,Nsteps,a,b);

%% check to make sure Nsteps is an integer and 
if mod(Nsteps,1)~=0 && Nsteps<2
	exception = 'YOU MUST USE A POSITIVE, integer VALUE >2 FOR Nsteps!!';
	error(exception)
end

    h=(b-a)/Nsteps;
    
    %% get the endpoints, which both have the same factor.
    %% this first point is for the "oth" term
    summand(1)=(h/3)*walker_function_list(integrand,a);
    %% this is the last term of the integration
    summand(Nsteps+1)=(h/3)*walker_function_list(integrand,b);
    j=2;
    while(j<=Nsteps)     
        x(j)=a+(j-1)*h;
        if mod(j-1,2)~=0
            %% this is for odd terms
            summand(j) = (4*h/3)*walker_function_list(integrand,x(j));
            %disp('you are odd')
        else
            %% this corresponds to the even terms
            summand(j) = (2*h/3)*walker_function_list(integrand,x(j));
            %disp('you are even')
        end
        j=j+1;
    end
    summand;
    area=sum(summand);
%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% 
    
end