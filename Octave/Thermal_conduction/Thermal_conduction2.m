more off;
%close all;
clc;
clear all;

%----------------------------------------------------------------------------
%parametrien määritys

nx = 100; %palojen määrä
lx = 1.0; %m

%alkuarvot
c_Pb = 129.0; % J/kg*K
c_Cu = 385.0; % J/kg*K
k_Pb = 35.0; % W/(K*m)
k_Cu = 390.0; % W/(K*m)
rho_Pb = 11340.0; % kg/m^3
rho_Cu = 8960.0; % Kg/m^3
T_Pb = (90+273.15);
T_Cu = (0+273.15);
   
T = zeros(1, nx);
c = zeros(1, nx);
k = zeros(1, nx);
rho = zeros(1, nx);
px = linspace(0, lx, nx);

raja=0.1;

c(px <= raja*lx) = c_Pb;
c(px > raja*lx) = c_Cu;
T(px <= raja*lx) = T_Pb;
T(px > raja*lx) = T_Cu;
k(px <= raja*lx) = k_Pb;
k(px > raja*lx) = k_Cu;
rho(px <= raja*lx) = rho_Pb;
rho(px > raja*lx) = rho_Cu;


%----------------------------------------------------------------------------
%laskenta

data.c = c;
data.T = T;
data.k = k;
data.rho = rho;
dt = 0.1;
t = 0.0;
tPrev = 0.0;

for i = 1:20000
  data.T = T;
  data.dx = px(2) - px(1);
  data2 = Thermal_calculation2(data, dt);
  T = data2.T;
  t=t+dt;
  Etotal=sum(data.T.*data.rho.*data.c);
  if(t>tPrev)
    tPrev=tPrev+1.0;
    Plotti_Thermal(px, T, sprintf('Lämpöjakauma t=%d s\nEtotal=%f', t, Etotal));
    ylim([270, 380]);
    pause(0.01);
  end
endfor


