%Laskee aika askeleen l�mm�njohtumiselle
%input muuttujat 
%Data structin muuttujat
% data.dx = tyyppi: double koko:1, laskenta solun pituus [m]  
% data.Tx = tyyppi: double koko:x vektori, laskenta solun l�mp�tila [K]
% data.c = tyyppi: double koko:x vektori, laskenta solun l�mp�kapasiteetti [J/K]
% data.rho = tyyppi: double koko:x vektori, laskenta solun materiaalin tiheys [kg/m^3]
% data.k = tyyppi: double koko:x vektori, laskenta solun materiaalin l�mm�njohtavuus [W/(k*m)]
% dt = aika askel [s]
%output muuttujat 
% ret = data solujen laskettu l�mp�tila aika askeleen j�lkeen [s]
 
function ret = Thermal_calculation(data, dt)
  % Lämpötilan paikkaderivaatta solussa
  tempx = [data.Tx(1), data.Tx, data.Tx(end)] ;
  d1Tx = diff(tempx)./data.dx;
  d2Tx = -data.k.*diff(d1Tx)./data.dx;  
  vakiox = 1.0 ./(-data.rho .* data.c);
  
  tempy = [data.Ty(1), data.Ty, data.Ty(end)] ;
  d1Ty = diff(tempy)./data.dy;
  d2Ty = -data.k.*diff(d1Ty)./data.dy;  
  vakioy = 1.0 ./(-data.rho .* data.c);
  
  %Euler step
  ret.Tx = data.Tx + vakiox.* d2Tx .* dt;
  ret.Ty = data.Ty + vakioy.* d2Ty .* dt;
  
  
  ret.d1Tx = d1Tx;
  ret.d2Tx = d2Tx; 
end