%% Jeffrey J. Walker
%% CPP 782, HW #10, problem #4


B=[1,5,10,50,100,500,1000,5000,10000];
ni=[4.97e13,3.37e13,1.32e13,1.54e13,1.53e13,1.72e13,1.84e13,1.87e13,1.85e13];
 
plot(B,ni,'d','MarkerFace','b','MarkerSize',14);
set(gca,'fontsize',16);
title('Argon ion density')
xlabel('Magnetic Field (Gauss)') 
ylabel('Argon ion density (m^{-3})')
legend('OOPIC Data')
