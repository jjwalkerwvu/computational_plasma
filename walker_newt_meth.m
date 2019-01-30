%% Jeffrey J. Walker
%% CPP 782, HW #2, problem 7
%% 
%% This is a simple program for finding the root of a specific quadratic using 
%% Newton's method. I added a "combing" function that first determines how 
%% many total roots are in the domain before performing the actual root finding. 
%% I could have guessed that the function:
%%
%% 	f(U) = C*U^4 - B*U^2 + A 
%%
%% was symmetric about the x=0 line, but I chose to make the algorithm more 
%% robust in case I need to use it in the future. I think this should work 
%% for any function, and will find all the roots in the domain specified by 
%% the user, provided the "combs" are small enough.
%%
%% Also note: the search domain of the combing or probing function is [-domain, +domain], 
%% so you must use a positive definite quantity for the domain; I recommend 
%% using |domain| = 1 for this hw problem.

function [x]= walker_newt_meth(domain);
%% c is the output of the function, which is/are the root(s). +/- domain are 
%% the endpoints of the search

%% error handling:
if sign(domain)<0
	exception = 'YOU MUST USE A POSITIVE DEFINITE VALUE FOR THE DOMAIN!!!';
	error(exception)
end
%% declare some constants first:
C = -0.5;
B=0.1;
A=0.25;

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% Send out two "COMBS" from the origin to search for roots.
%% This is a quick algorithm to find an interval where the function changes 
%% sign. Uses the interval: [-domain, domain], so it is symmetric about the 
%% origin.

% size of the comb to use for the search; we're looking to see if the function changes sign
% in this interval which gets updated by an integer step each time through the loop.

comb_size = 1e-1;	% this is small enough to work for the particular case of HW#2, problem 7,
		%  but I'd like to have it as an input to the function. The smaller the 
		% comb_size, the better the chance of finding an interval where
		% a root appears, but it will also increase computational time.
		% A smaller comb_size should make newton's method run faster, and gives
		% it two very good initial guesses. 
		
		
% comb_a is the "leftmost" endpoint of the search domain (for the positive part), start it off at zero
comb_a = 0;
% likewise, comb_a is the "rightmost" endpoint of the search domain, start it off as:
comb_b =comb_a+comb_size;
% loop counter
j =1;
% initialize the "root" index. This corresponds to the first root that the search algorithm finds,
% and i will end up being as big as the 
i=1;

while comb_b<=domain
	% calculate the given function on the endpoints for the positive interval.
	f_a_plus = C*comb_a^4 - B*comb_a^2 + A;
	f_b_plus =  C*comb_b^4 - B*comb_b^2 + A;
	% find out if there is a root in the interval [comb_a, comb_b]
	if sign(f_a_plus)~=sign(f_b_plus)
		a(i) = comb_a;
		b(i) = comb_b;
		i=i+1;
	end
	% calculate the given function on the endpoints for the negative interval.
	% a little weird here, because the a's and b's need to be switched so that
	% they are set up correctly for the binary search algorithm
	f_a_minus = C*(-comb_b)^4 - B*(-comb_b)^2 + A;
	f_b_minus =  C*(-comb_a)^4 - B*(-comb_a)^2 + A;
	% find out if there is a root in the interval: [-comb_b,-comb_a]
	if sign(f_a_minus)~=sign(f_b_minus)
		a(i) = -comb_b;
		b(i) = -comb_a;
		i=i+1;
	end
	
	comb_a = comb_b;
	% I think this line below is okay, because comb_b should generally be
	% a rational number 
	comb_b= comb_b+comb_size;
	
	% I ended up not having to use the loop counter, but I left it here anyway
	j=j+1;
end

%%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% NEWTON METHOD ALGORITHM
%% First figure out how big the a(i), b(i) arrays are; this will determine how many times 
%% we need to run the search algorithm
 [m,ind]=size(a);

% Nmax is the max number of iterations, to prevent an infinite loop
Nmax = 10000;
% tol is the tolerance allowed. this could potentially be an input for the function
tol = 1e-8;
% n is the iteration counter, initialized to 1
n=1;

%% In the following loop, scroll through the known areas where roots occur, then use newton's method
%% to find them. This will converge very quickly.
for i=1:ind
	% initialize x with the guess; pick halfway in between a valid domain
	x(i)=0.5*a(i)+0.5*b(i);
	% initialize the error, perhaps the size of the domain
	err(i)=b(i)-a(i);
	
	while n<=Nmax && abs(err(i))>tol;
		f = C*x(i)^4 - B*x(i)^2 + A;
		f_deriv = 4*C*x(i)^3 - 2*B*x(i);
		if f_deriv==0
			exception ='You ended up dividing by zero =(';
			error(exception);
		end
		last_term = x(i);
		% update the root approximation
		x(i)=x(i) - f/f_deriv;
		% the error, from the notes:
		err(i) = last_term-x(i);
		n=n+1;
		
	end
	disp('number of steps needed to converge');disp(n)
	disp('error');disp(err(i))
	%%% reset the counter after a root has been found!
	%%% we're now ready to look for another one.
	n=1;
end

disp('The root(s) is/are: ')
disp(x)

end