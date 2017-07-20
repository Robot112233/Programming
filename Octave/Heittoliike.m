%Vakiot
a=35; %Kulma
v=100; %Lähtönopeus
g=9.81;

%Lentoaika
s=2*v*sind(a)/9.81;
t=[0:0.001:s];

%Etäisyys ja korkeus
x=v*cosd(a)*t;
y=v*sind(a)*t-0.5*9.81*t.^2;

plot(x,y);
