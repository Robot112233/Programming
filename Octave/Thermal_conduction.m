clc;
clear all;
%Note to self BUG IN CODE !!! T_Cold Explodes! 
m_H2O = 5000.0; %kg 
X_Fe = 3.0; %m
y_Fe = 10.0; %m
rho_Fe = 7.87E03; %Kg/m^3
V_Fe = X_Fe * y_Fe; %m^3
m_Fe  = rho_Fe / V_Fe; %kg
k_Fe = 80.4; %w/m*k
A_Fe = X_Fe*y_Fe;
c_H2O = 4190.0; % J/kg*K
c_Fe = 470; % J/kg*K
%temperatures
T_Hot_H2O = (90.0+273.15);
T_Cold_H2O = (0+273.15);
T_Cold_Fe = (0+273.15);
T_Hot_Fe = (90+273.15);
dt = 0.001; %s 
T_Hot_Fe_start = (0+273.15);
Q_Fe =  m_Fe*c_Fe * (T_Hot_Fe_start - T_Cold_Fe);


%Conduction dQ = dt*k*A*(t_h - t_c)/L
% Heat requirement to change temperature dQ=mcdT

T_Hot_Fe_matrix = [];
T_Cold_H2O_matrix = [];
%starting parameter 
T_Cold_H2O_matrix = [T_Cold_H2O_matrix, T_Hot_H2O]; 
T_Hot_Fe_matrix = [T_Hot_Fe_matrix, T_Hot_Fe_start];

do
  %Heat decrease in water
  Q_H2O = m_H2O*c_H2O * (T_Hot_H2O-T_Cold_H2O);
  %Transferred heat capacity
  Q2 = (k_Fe.*A_Fe.*((T_Hot_Fe-T_Cold_Fe)./X_Fe)).*dt + Q_H2O;
  %Water cooling due to heat transfer
  T_Cold_H2O = -((Q2-Q_H2O)./m_H2O.*c_H2O)+T_Hot_H2O; 
  %Fe temperature increase by thermal coduction
  T_Cold_Fe = ((Q2-Q_Fe)./m_Fe.*c_Fe)+T_Hot_Fe_start;
  %Heat incrase Fe
  Q_Fe =  m_Fe.*c_Fe*(T_Cold_Fe-T_Hot_Fe_start);
  %data gathering and value change
  T_Cold_H2O_matrix = [T_Cold_H2O_matrix, T_Cold_H2O];
  T_Hot_H2O = T_Cold_H2O;
  T_Hot_Fe = T_Cold_Fe;
  T_Hot_Fe_start = T_Cold_Fe;
  T_Hot_Fe_matrix = [T_Hot_Fe_matrix, T_Hot_Fe_start];
until (T_Cold_H2O = T_Hot_Fe) 
figure(1);
plot(T_Cold_H2O_matrix);
figure(2);
plot(T_Hot_Fe_matrix);
