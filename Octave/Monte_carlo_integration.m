#Monte-carlo method used to integrate function 2x*cosx*e^x 0 to 5
f = 0;
a = 0;
b= 5;
n=1000000;

x=a+(b-a)*rand(1,n);

for i=1:n
  f = f + 2*x(i)*cos(x(i))*e^x(i);
end
f = ((5-0)/n)*f
