from random import randint, seed 

_seed=234

class Dice :
	def __init__ (self,val_seed) : 
		seed(val_seed)

	def RolltheDice(self) :
		return randint(1,6)

val_seed=234 
mon_de=Dice(val_seed) 
mon_de.RolltheDice()

class EasyMonster : 
	def __init__ (self) : 
		pass
	def RolltheDice(self) :
		return(mon_de.RolltheDice())
	def attack(self):
		return(1)

class DifficultMonster (EasyMonster) :
	def __init__(self) :
		EasyMonster.__init__(self)
	def RolltheDice(self) :
		return(EasyMonster.RolltheDice(self))
	def attack(self):
		att=self.RolltheDice()
		if att == 6 :
			att=0	
		return(att)

class Player : 
	def __init__ (self) : 
		self.pv=10
		self.score=0
	def RolltheDice(self) :
		return(mon_de.RolltheDice())

def phaseATK (p,m,t) :
	atkM=m.RolltheDice()
	print("le monstre lance le dé et obtient")
	print(atkM)
	atkPlayer=p.RolltheDice()
	print("le hero lance le dé et obtient")
	print(atkPlayer)
	if atkPlayer>atkM :
		if t :
			p.score+=2
			print("le hero a vaincu le monstre et augmente son score de 2")
			print("le hero a un score de")
			print(p.score)
		else :
			p.score+=1
			print("le hero a vaincu le monstre et augmente son score de 1")
			print("le hero a un score de")
			print(p.score)
		return 0
	if atkPlayer==atkM :
		print("les 2 doivent relancer le dé")
		return phaseATK(p,m,t)
	else :
		print("c'est au monstre d'attaquer")
		atkM=m.attack()
		if t==True :	
			if atkM==6 :
				print("le hero se protège à l'aide de son bouclier magique")
				return 0
			else :
				p.pv-=atkM
				print("le monstre attaque en lançant les dés. Le hero perd ce nombre de vie")
				print(atkM)
				print("il lui reste")
				print(hero.pv)
		else :
				p.pv-=1
				print("le monstre attaque. Le hero perd ce nombre de vie")
				print(1)
				print("il lui reste")
				print(hero.pv)

			


hero=Player()
print("le hero avance")

while hero.pv>0 :
	diff=False
	if mon_de.RolltheDice() > 3 :
		monstre=DifficultMonster()
		print("un monstre facile arrive")
		diff=True
	else :
		monstre=EasyMonster()
		print("un monstre difficile arrive")
	phaseATK(hero,monstre,diff)
print("le hero est vaincu avec ce score")
print(hero.score)


	
		






