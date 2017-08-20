function Plotti_Thermal(px, py, Tx, titleString)
  imagesc(px, py, Tx);
  set(gca, "linewidth", 1, "fontsize", 17);
  title(titleString); 
end
  
