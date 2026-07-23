extends Node2D
#Basic Player Stats
var health: int = 100
var sanity: int = 45
var hunger: int = 100
var cold: int = 100
var sleep: int = 100
#Mechanics
var hunger_reduction: float = 5
var cold_reduction: float = 2.5
var time: float = 250

func hunger_decay():
	check_status()
	if hunger == 0:
		health -= 10
	if hunger != 0:
		hunger -= hunger_reduction
		print(hunger)
		if hunger <= 0:
			print ("starve")
	check_status()
func cold_decay():
	check_status()
	if cold == 0:
		health -= 10
	if cold != 0:
		cold -= cold_reduction
		print(cold)
		if cold <= 0:
			print ("freeze")
	check_status()

func check_status():
	if health <= 0:
		game_over()
	
func game_over():
	get_tree().change_scene_to_file("res://Menu.tscn")
	
