%% Jeffrey J. Walker
%% CPP 782, HW #11, problem #1


beam=[15,18,20,25,28,30,35,40,45,50];  %% beam energy in eV
n_Ar=[4.78e10,2e12,5e12,5e13,1e13,1e13,1.1e13,1.2e13,1.4e13,1.5e13];
n_He=[0,0,0,5.8e10,6e11,9e11,1.6e12,5.4e12,6.6e12,5e12]

plot(beam,n_Ar,'s','MarkerFace','b','MarkerSize',14);
hold on;
plot(beam,n_He,'dr','MarkerFace','r','MarkerSize',14);

set(gca,'fontsize',16);
title('Ion densities')
xlabel('Beam energy (eV)') 
ylabel('Density (m^{-3})')
legend('Ar Density','He Density')
