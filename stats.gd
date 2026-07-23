extends Node2D
#Basic Player Stats
var health: int = 100
var sanity: int = 45
var hunger: int = 100
var cold: int = 100
var sleep: int = 100
#Mechanics
var hunger_reduction: float = 5
var cold_reduction: float = 5
var sleep_reduction: float = 5
var time:float = 250
#other stuff
var update:int = 0

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
func sleep_decay():
	check_status()
	if sleep == 0:
		if sanity >-45:
			sanity -= 5
			if sanity < 0:
				print ("you are going insane")
	if sleep != 0:
		sleep -= sleep_reduction
		print(sleep)
		if sleep <= 0:
			print ("exhuasted")
	check_status()

func check_status():
	update = 1
	if health <= 0:
		game_over()
#very important stuff for the rest of the game
func game_over():
	get_tree().change_scene_to_file("res://Menu.tscn")
func initalize():
	health = 100
	sanity = 45
	hunger = 100
	cold = 100
	sleep = 100
	time = 250

func action_decay():
	#add check for eating 
	hunger_decay()
	#add check for fireplace
	cold_decay()
