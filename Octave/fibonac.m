#fibonaccin lukujono
a=0;
b=1;
for n=1:1000
  if (rem (n, 2) == 0)
  a=a+b;
  printf("%d \n",a);
  else
  b=a+b;
  printf("%d \n",b);
endif
endfor
    
