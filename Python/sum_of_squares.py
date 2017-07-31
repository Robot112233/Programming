# -*- coding: utf-8 -*

"""
For a positive integer n, let σ2(n) be the sum of the squares of its divisors. For example,
σ2(10) = 1 + 4 + 25 + 100 = 130.

sum of all n, 0 < n < 64,000,000 such that σ2(n) is a perfect square.
"""
#python 3.6.2 code


def square(digit):
	square = 0
	for i in range(1,int(digit)+1):
		if(int(digit)%i == 0):
			square=square+(int(digit)/i)*(int(digit)/i)
	return square


print("the sum of the squares of it's divisors is:",square(input("Give a number:")))
