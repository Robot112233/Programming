# -*- coding: utf-8 -*

"""
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
"""

#python 3.0 code

def multiples(num):
	a=0
	taulu = []
	for i in range(1,num+1):
	 	if i % 3 == 0:
	 		a=a+i
	 		taulu.append(i)
	 	if i % 5 == 0:
	 		a=a+i
	 		taulu.append(i)
	print("Kerrannaiset:",*taulu)
	return a

print("summa:",multiples(int(input("Anna luku: "))))
