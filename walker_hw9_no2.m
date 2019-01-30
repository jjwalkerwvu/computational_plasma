%% Jeffrey J. Walker
%% CPP 782, HW #9, problem #1

% divide by 2*pi make sure t is units of 1/(plasma frequency)
t=[0,2.14,4.78,7.4,9.95,12.6,15.3]/(2*pi);
amp=[1.89,2.23,2.47,2.68,2.92,3.18,3.44];
 
plot(t,log(amp),'s','MarkerFace','b','MarkerSize',14);
hold on;

%% I picked the rate below on the criterion of best matching the semi-log
%% plot from above.
r=0.22;
t_fit=linspace(0,3,1000);
y_fit=.7+r*t_fit;
plot(t_fit,y_fit,'--r','linewidth',2)
set(gca,'fontsize',16);
title('Damping rate')
xlabel('time,(\omega_p)^{-1}') 
ylabel('ln(amplitude)')
legend('ES1 Data','Fit (damping rate = 0.22 (\omega_p)^{-1})')
