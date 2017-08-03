#planck's law
h=6.6260755E-34; #planck constant
c=2.99792458E8;  #speed of light
k=1.380658E-23; #Bolzman constant 
l=[1E-8:1E-10:1E-5]; #Wavelength (0.01-10) micrometers
Color={"red","green","blue","black","yellow"}
i=1;
for T=1000:1000:5000
  B=(2.*h.*c.^2)./(l.^5.*exp((h.*c)./(l.*k.*T)-1));
  plot(l,B,"color",Color{1,i},"linewidth",2)
  i=i+1;
  hold on
  grid
end
xlabel('Wavelength')
ylabel('Intensity')
title("Planc \'s law")
legend('T=1000K','T=2000K','T=3000K','T=4000K','T=5000K')
hold off
