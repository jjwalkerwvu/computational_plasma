%% Jeffrey J. Walker
%% CPP 782, HW #3, problem #1
%% 
%% This is a simple script to calculate all the integrals in problem 1.
j=2;
k=1;
while j<=512
    
    prob_1a(k) = walker_simpson('1a',j,0,pi);
    k=k+1;
    j=2^(k-1);
end

j=2;
k=1;
while j<=512
    
    prob_1b(k) = walker_simpson('1b',j,0,1);
    k=k+1;
    j=2^(k-1);
end

j=2;
k=1;
while j<=512
    
    prob_1c(k) = walker_simpson('1c',j,-pi,pi);
    k=k+1;
    j=2^(k-1);
end