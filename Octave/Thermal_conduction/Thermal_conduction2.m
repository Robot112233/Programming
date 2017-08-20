more off;
%close all;
clc;
clear all;

%----------------------------------------------------------------------------
%parametrien m��ritys

nx = 100.0; %palojen m��r�
lx = 1.0; %m
ny = 100.0; 
ly = 1.0;


%alkuarvot
c_H2O = 4190.0; % J/kg*K
c_Cu = 385; % J/kg*K
k_H2O = 0.6; % W/(K*m)
k_Cu = 390.0; % W/(K*m)
rho_H2O = 1000.0; % kg/m^3
rho_Cu = 8960.0; % Kg/m^3
T_H2O = (10+273.15);
T_Cu = (0+273.15);
   
Tx = zeros(1, nx);
c = zeros(1, nx);
k = zeros(1, nx);
rho = zeros(1, nx);
px = linspace(0, lx, nx);

Ty = zeros(1, ny);
py = linspace(0, ly, ny);


raja=0.3;

c(px <= raja*lx) = c_H2O;
c(px > raja*lx) = c_Cu;
Tx(px <= raja*lx) = T_H2O;
Tx(px > raja*lx) = T_Cu;
k(px <= raja*lx) = k_H2O;
k(px > raja*lx) = k_Cu;
rho(px <= raja*lx) = rho_H2O;
rho(px > raja*lx) = rho_Cu;

Ty(py <= raja*ly) = T_H2O;
Ty(py > raja*ly) = T_Cu;



%----------------------------------------------------------------------------
%laskenta

data.c = c;
data.k = k;
data.rho = rho;
dt = 0.1;
t = 0.0;
  
for i = 1:1000000
  data.Tx = Tx;
  data.Ty = Ty;
  data.dx = px(2) - px(1);
  data.dy = py(2) - py(1);
  data2 = Thermal_calculation(data, dt);
  Tx = data2.Tx;
  Ty = data2.Ty;
  t=t+dt;
  if mod(i, 500)==0
    Plotti_Thermal(px, py, Tx, sprintf('Lämpöjakauma t=%d s', t));
    %ylim([270, 380]);
    pause(0.1);
  end
endfor

%----------------------------------------------------------------------------
%plottaukset

%subplot(2,2,1);
%Plotti_Thermal(px, T, 'L�mp�jakauma');
%ylim([273.15, 373.15]);
%subplot(2,2,2);
%Plotti_Thermal(px, c,'L�mp�kapasiteetti');
%subplot(2,2,3);
%Plotti_Thermal(px, data2.d1Tx, 'ensimm�inen x paikkaderivaatta');
%subplot(2,2,4);
%Plotti_Thermal(px, data2.d2Tx, 'toinen x paikkaderivaatta');


%plot(px, data2.T./max(data2.T), 'b');
%hold on;
%plot(px, data2.d1Tx./max(abs(data2.d1Tx)), 'r');
%plot(px, data2.d2Tx./max(abs(data2.d2Tx)), 'g');
%hold off;

