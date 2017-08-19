more off;
%close all;
clc;
clear all;

m_H2O = 20.0; %kg 
X_Fe = 0.30; %m
y_Fe = 0.30; %m
z_fe = 0.30; %m
rho_Fe = 7.87E03; %Kg/m^3
V_Fe = X_Fe * y_Fe *z_fe; %m^3
m_Fe  = rho_Fe * V_Fe; %kg
k_Fe = 80.4; %w/m*k
A_Fe = X_Fe*y_Fe;
c_H2O = 4190.0; % J/kg*K
c_Fe = 470; % J/kg*K
%temperatures
T_Hot_H2O = (90.0+273.15);
T_Cold_H2O = (0);
T_Cold_Fe = (0+273.15);
dt = 60; %s 

%Conduction dQ = dt*k*A*(t_h - t_c)/L
% Heat requirement to change temperature dQ=mcdT

T_Hot_Fe_matrix = [];
T_Cold_H2O_matrix = [];
%starting temps to matrix 
T_Cold_H2O_matrix = [T_Cold_H2O_matrix, T_Hot_H2O-273.15]; 
T_Hot_Fe_matrix = [T_Hot_Fe_matrix, T_Cold_Fe-273.15];
tValues=[0.0];
t=0;
for i = 0:200
  %Transferred heat capacity
  Q = k_Fe.*A_Fe.*((T_Hot_H2O-T_Cold_Fe)./X_Fe).*dt;
  %Water cooling 
  T_Cold_H2O = T_Hot_H2O - (Q./(m_H2O.*c_H2O));
  %Fe temperature increase by thermal coduction
  T_Hot_Fe = (Q./(m_Fe.*c_Fe)) + T_Cold_Fe;
 
  %data gathering and value change
  T_Cold_H2O_matrix = [T_Cold_H2O_matrix, T_Hot_H2O-273.15];
  T_Hot_H2O = T_Cold_H2O;
  T_Cold_Fe = T_Hot_Fe;
  T_Hot_Fe_matrix = [T_Hot_Fe_matrix, T_Hot_Fe-273.15];
  t=t+dt;
  tValues = [tValues, t];
endfor
plot(tValues, T_Cold_H2O_matrix, 'b-', 'linewidth', 2);
set(gca, "linewidth", 1, "fontsize", 17); 
hold on
plot(tValues, T_Hot_Fe_matrix,'r-', 'linewidth', 2);
xlabel('Time (s)','fontsize', 18);
ylabel('Temperature (\deg C)','fontsize', 18);
title(' 20 Kg 90\deg C water used to heat 212.5 kg 0\deg C iron through conduction','fontsize', 16)
a = legend("Water","Fe");
set(a,"fontsize", 20);
xlim([0, max(tValues)]);
hold off
grid on
