extends Node2D
#Basic Player Stats
var health: int = 100
var sanity: int = 45
var hunger: int = 100
var cold: int = 100
var sleep: int = 100
#Mechanics
var hunger_reduction: float = 5
var time: float = 250

func hunger_decay():
	hunger -= hunger_reduction
	print(hunger)
