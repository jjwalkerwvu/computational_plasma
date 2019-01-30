function [f_x] = walker_function_list(case_label,x)
%% A useful list of functions that can be called by other external functions.
%% case_label is a string input that must match one of these functions
switch case_label
    case '1a'
        f_x = exp(x).*cos(4*x);
    case '1b'
        f_x = x.^(5/2);
    case '1c'
        f_x = exp(cos(x));
    %% gaussian function; for HW #3, problem 3 A)
    case 'gaussian'
        f_x = exp(-x.^2);
    %% 1-v^2 function in the interval -1<v<1 for HW #3, problem 3 B)
    case '1-v^2'
        f_x = (x>=-1).*(x<=1).*(1-x.^2);
    %% v*exp(-v) function for HW #3, problem 3 C), I called it EEDF because
    %% it has the same functional form as an eedf.
    case 'eedf'
        f_x = x.*exp(-x); 

%% error handling for incorrect string input:
% mistake=(case_label=='1a')||(case_label=='1b')||(case_label=='1c')||...
%     (case_label=='gaussian')||(case_label=='1-v^2')||(case_label=='eedf');
% if mistake==0
% 	exception = 'You must pick a valid function!';
% 	error(exception)
% end     
end



