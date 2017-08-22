more off;
%close all;
clc;
clear all;

%----------------------------------------------------------------------------
%parametrien määritys

nx = 20; %palojen määrä x-suunta
lx = 1.0; %m
ny = 20; %palojen määrä y-suunta
raja=0.2; %prosenttia x-suunnassa 


%alkuarvot
%Heat capacity [J/kg*K]
c_Pb = 129.0; 
c_Cu = 385.0; 
c_Au = 129.0;
c_Ag = 233.0;
%thermal conductivity [W/(K*m)]
k_Pb = 35.0;   
k_Cu = 390.0;  
k_Au = 315.0;  
k_Ag = 427.0;  
%Density [kg/m^3]
rho_Pb = 11340.0; 
rho_Cu = 8960.0;  
rho_Au = 1930.0;  
rho_Ag = 9320.0;
%Temperatures at start [K]
T_Pb = (300+273.15); 
T_Cu = (0+273.15);   
T_Au = (90+273.15); 
T_Ag = (200+273.15);  

   
T = zeros(ny, nx);
c = zeros(ny, nx);
k = zeros(ny, nx);
rho = zeros(ny, nx);
px = linspace(0, lx, nx);


for i = 1:ny
  if (i < (ny+1)/2.0)
    c(i, px <= raja*lx) = c_Pb;
    c(i, px > raja*lx) = c_Cu;
    T(i, px <= raja*lx) = T_Pb;
    T(i, px > raja*lx) = T_Cu;
    k(i, px <= raja*lx) = k_Pb;
    k(i, px > raja*lx) = k_Cu;
    rho(i, px <= raja*lx) = rho_Pb;
    rho(i, px > raja*lx) = rho_Cu;
  end
  if (i > ny/2.0)
    c(i, px <= raja*lx) = c_Au;
    c(i, px > raja*lx) = c_Ag;
    T(i, px <= raja*lx) = T_Au;
    T(i, px > raja*lx) = T_Ag;
    k(i, px <= raja*lx) = k_Au;
    k(i, px > raja*lx) = k_Ag;
    rho(i, px <= raja*lx) = rho_Au;
    rho(i, px > raja*lx) = rho_Ag;
  end
endfor 

%----------------------------------------------------------------------------
%laskenta

dt = 0.1;
t = 0.0;
tPrev = 0.0;

for i = 1:2000
  data.dx = px(2) - px(1);
  for i = 1:ny 
    data.T = T(i, :);
    data.c = c(i, :);
    data.k = k(i, :);
    data.rho = rho(i, :);
    data2 = Thermal_calculation2(data, dt);
    T(i, :) = data2.T();
   endfor
   for i = 1:nx 
    data.T = T(:, i)';
    data.c = c(:, i)';
    data.k = k(:, i)';
    data.rho = rho(:, i)';
    data2 = Thermal_calculation2(data, dt);
    T(:, i) = data2.T();
   endfor
  t=t+dt;
  Etotal=sum(data.T(1, :).*data.rho(1, :).*data.c(1, :));
  if(t>tPrev)
    tPrev=tPrev+1.0;
    figure(1);
    imagesc(linspace(0, lx, nx), linspace(0, lx, ny), T);
    colorbar();
    caxis([270, 600])
    figure(2);
    Plotti_Thermal(px, T(2, :), sprintf('Lämpöjakauma t=%d s\nEtotal=%f', t, Etotal));
    ylim([270, 600]);
    pause(0.01);
  end
endfor

