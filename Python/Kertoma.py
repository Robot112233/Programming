# -*- coding: utf-8 -*

def Factorial(num): 
	
	var=1
	for x in range(1,num+1):
		var=var*x	
	return var

print("Luvun kertoma on:",Factorial(int(input("Anna luku:"))))
