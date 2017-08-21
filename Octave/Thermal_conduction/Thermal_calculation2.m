%Laskee aika askeleen lämmönjohtumiselle
%input muuttujat 
%Data structin muuttujat
% data.dx = tyyppi: double koko:1, laskenta solun pituus [m]  
% data.T = tyyppi: double koko:x vektori, laskenta solun lämpötila [K]
% data.c = tyyppi: double koko:x vektori, laskenta solun lämpökapasiteetti [J/K]
% data.rho = tyyppi: double koko:x vektori, laskenta solun materiaalin tiheys [kg/m^3]
% data.k = tyyppi: double koko:x vektori, laskenta solun materiaalin lämmönjohtavuus [W/(k*m)]
% dt = aika askel [s]
%output muuttujat 
% ret = data solujen laskettu lämpötila aika askeleen jälkeen [s]
 
function ret = Thermal_calculation2(data, dt)
  % Lämpötilan 1:nen paikkaderivaatta
  d1Tx = diff(data.T)/data.dx;
  
  % Lämmänjohtavuuskerroin
  temp1 = data.k(1:end-1);
  temp2 = data.k(2:end);
  temp3 = 0.5*(temp1+temp2);
  d1Tx = -temp3.*d1Tx;  
  
  % Lämpötilan 2:nen paikkaderivaatta
  temp = [d1Tx(1), d1Tx, d1Tx(end)];
  d2Tx = diff(temp)/data.dx; 
  
  %Euler step
  vakio = 1.0./(-data.rho .* data.c); 
  ret.T = data.T + vakio.* d2Tx .* dt;
  
  ret.T(1) = ret.T(2);
  ret.T(end) = ret.T(end-1);
  
end
