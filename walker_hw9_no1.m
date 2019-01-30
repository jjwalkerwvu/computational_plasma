%% Jeffrey J. Walker
%% CPP 782, HW #10, problem #3


pressure=[1e-4,5e-4,1e-3,5e-3,1e-2,5e-2,8e-2,0.1];
ni=[8.3e12,1e13,1.15e13,4e13,4.1e13,1e14,1.4e14,1.6e14];
 
plot(pressure,ni,'s','MarkerFace','b','MarkerSize',14);
set(gca,'fontsize',16);
title('Damping rate')
xlabel('time,(\omega_p)^{-1}') 
ylabel('ln(amplitude)')
legend('ES1 Data','Fit (damping rate = 0.22 (\omega_p)^{-1})')
