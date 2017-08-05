#Monte-carlo method used to integrate

f = 0;
n=10000000;
ans = 0;
#------------------X-----------------

a = 0; 
b = 5;
x=a+(b-a)*rand(1,n);

#------------------Y-----------------

c = 0;
d = 5;
y=c+(d-c)*rand(1,n);

#------------------Z-----------------

e = 0;
f = 5;
z=e+(f-e)*rand(1,n);

#--------------numerical-integral------------
s_list = 2.*x(1:n)+cos(y(1:n)).^5+sin(z(1:n));

s = sum(s_list(:));

ans = (((b-a)*(d-c)*(f-e))/n)*s

