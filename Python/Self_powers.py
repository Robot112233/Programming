# -*- coding: utf-8 -*
"""
The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317
Last ten digits of any series.
"""

#python 3.6.2 code

def digits(summ):
	table=str(summ)
	answer=[]
	
	if (len(table) < 10):
		return(''.join(table))
	
	else:
		for i in range(0,10):
			answer.append(table[(len(table)-10)+i])
		return(''.join(answer))

#--------------------------------------------------------------

def loop(i):
	y=1
	limit = i
	multiplicand = i 
	
	while (y < limit):	
		i = i*multiplicand	
		y=y+1
	return(i)
	
#--------------------------------------------------------------

def calc(var):
	summ=0
	for i in range(1,int(var)+1):
		summ = summ+loop(i)	
	return(digits(summ))

print("Last ten digits:",calc(input("Give a number: ")))
