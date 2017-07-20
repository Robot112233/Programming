# -*- coding: utf-8 -*
def pascal(jono):
	jono1 = []
	jono2 = []

	for i in range (0,jono):
		if i == 0:
			print("1")
	
		if i >= 1:
			jono1.append(1)
		
			if len(jono2) >= 2:
				for h in range(len(jono2)-1):
					jono1.append(jono2[h]+jono2[h+1])
				 
			jono1.append(1)
			jono2 = jono1
			jono1 = []
			print(*jono2)

pascal(int(input("rivien määrä: ")))