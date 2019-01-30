%% Jeffrey J. Walker
%% CPP 782, HW #9, problem #3

% divide by 2*pi make sure t is units of 1/(plasma frequency)
t=[0.96,3.6,7.2,10.7,14,17.4,21,24.6,28.3,31.7,35,38.4]/(2*pi);
amp=[3.1,3.13,3.28,3.44,3.64,3.85,4.04,4.23,4.39,4.44,4.55,4.68];
 
plot(t,log(amp),'s','MarkerFace','b','MarkerSize',14);
hold on;

%% I picked the rate below on the criterion of best matching the semi-log
%% plot from above.
r=0.08;
t_fit=linspace(0,6,1000);
y_fit=1.1+r*t_fit;
plot(t_fit,y_fit,'--r','linewidth',2)
set(gca,'fontsize',16);
title('Damping rate')
xlabel('time,(\omega_p)^{-1}') 
ylabel('ln(amplitude)')
legend('ES1 Data','Fit (damping rate = 0.08 (\omega_p)^{-1})')
