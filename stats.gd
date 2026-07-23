extends Node2D

var health: int = 100
var sanity: int = 45
var hunger: int = 100
var hunger_reduction: float = 5

func hunger_decay():
	hunger -= hunger_reduction
	print(hunger)
