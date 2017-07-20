# -*- coding: utf-8 -*
"""
n! means n × (n − 1) × ... × 3 × 2 × 1.
For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.
"""
def summa(var):
	summa = 0
	luku = str(var)
	
	for b in range(len(luku)):
		summa = summa+int(luku[b])
	return summa

def Factorial(num): 
	
	var=1
	for x in range(1,num+1):
		var=var*x
	
	print("luvun kertoma:",var)	
	return summa(var)

print("Luvun kertoman lukujen summa on:",Factorial(int(input("Anna luku:"))))
