function Plotti_Thermal(px, T, titleString)
  plot(px, T);
  set(gca, "linewidth", 1, "fontsize", 17);
  title(titleString); 
end
  