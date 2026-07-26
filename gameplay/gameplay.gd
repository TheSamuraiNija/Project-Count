extends Node2D

# ---------------------------------------------------------
# EXPORTS (BALANCING)
# ---------------------------------------------------------

@export var current_room: String = "bedroom"
@export var ENERGY_DRAIN := 3.0
@export var INSIDE_COLD_RATE := 2.0
@export var OUTSIDE_COLD_RATE := 6.0
@export var SLEEP_RATE := 20.0
@export var FIREPLACE_BURN_TIME := 10.0
@export var FIRE_WARMTH_RATE := 15.0
@export var COOK_TIME := 3.0
@export var CRAFT_TIME := 6.0
@export var BIGCOUNTER_TIME := 120.0
@export var HUNGER_DRAIN := 2.0

# ---------------------------------------------------------
# NODES
# ---------------------------------------------------------

@onready var room_container := $roomContainer
@onready var hunger_bar := $ui/statsPanel/hungerLabel/hungerBar
@onready var warmth_bar := $ui/statsPanel/warmthLabel/warmthBar
@onready var energy_bar := $ui/statsPanel/energyLabel/energyBar
@onready var day_timer_label := $ui/statsPanel/dayTimerLabel
@onready var inventory_label := $ui/statsPanel/inventoryLabel
@onready var cooking_ready_label := $ui/statsPanel/cookingReadyLabel
@onready var crafting_ready_label := $ui/statsPanel/craftingReadyLabel

# ---------------------------------------------------------
# STATS
# ---------------------------------------------------------

var hunger := 100.0
var warmth := 100.0
var energy := 100.0

# ---------------------------------------------------------
# STATE FLAGS
# ---------------------------------------------------------

var sleeping := false
var fireplace_lit := false
var fireplace_timer := 0.0
var cooking := false
var cooking_timer := 0.0
var cooking_ready := false
var crafting := false
var crafting_timer := 0.0
var crafting_ready := false
var bigcounter_timer := 0.0

# ---------------------------------------------------------
# ONE-ITEM INVENTORY
# ---------------------------------------------------------

var holding_wood := false
var holding_raw_food := false
var holding_cooked_food := false
var holding_plank := false
var holding_tools := false

func is_holding_item() -> bool:
	return holding_wood or holding_raw_food or holding_cooked_food or holding_plank

func trash_item():
	holding_wood = false
	holding_raw_food = false
	holding_cooked_food = false
	holding_plank = false
	holding_tools = false

# ---------------------------------------------------------
# WINDOW BOARDING SYSTEM
# ---------------------------------------------------------

var boarded_windows := {}

func reinforce_window_named(window_name: String):
	if not holding_plank:
		return
	if boarded_windows.has(window_name):
		return
	holding_plank = false
	boarded_windows[window_name] = true
	survival_score += 1

# ---------------------------------------------------------
# SURVIVAL SCORE
# ---------------------------------------------------------

var survival_score := 0

# ---------------------------------------------------------
# READY
# ---------------------------------------------------------

func _ready():
	bigcounter_timer = BIGCOUNTER_TIME
	load_room(current_room)
	$Sfx/ambiant1.play()

	
# ---------------------------------------------------------
# ROOM SYSTEM
# ---------------------------------------------------------

func play_ambient(room_name: String):
	$Sfx/ambiant4.stop()

	if room_name == "outside":
		$Sfx/ambiant4.play()

func load_room(room_name: String):
	current_room = room_name
	for child in room_container.get_children():
		child.queue_free()
	var scene_path := "res://rooms/%s.tscn" % room_name
	var scene := load(scene_path)
	var instance: Node = scene.instantiate()
	instance.gameplay = self
	room_container.add_child(instance)
	play_ambient(room_name)
	update_ui()

# ---------------------------------------------------------
# MAIN GAME LOOP
# ---------------------------------------------------------

func _process(delta):
	bigcounter_timer -= delta
	if bigcounter_timer <= 0:
		evaluate_day()

	hunger -= HUNGER_DRAIN * delta
	energy -= ENERGY_DRAIN * delta

	if current_room == "Outside":
		warmth -= OUTSIDE_COLD_RATE * delta
	else:
		warmth -= INSIDE_COLD_RATE * delta

	if sleeping:
		energy += SLEEP_RATE * delta

	if fireplace_lit:
		fireplace_timer -= delta
		if fireplace_timer <= 0:
			fireplace_lit = false

	if fireplace_lit and current_room == "bedroom":
		warmth += FIRE_WARMTH_RATE * delta

	if cooking:
		cooking_timer -= delta
		if cooking_timer <= 0:
			finish_cooking()

	if crafting:
		crafting_timer -= delta
		if crafting_timer <= 0:
			finish_crafting()

	hunger = clamp(hunger, 0, 100)
	warmth = clamp(warmth, 0, 100)
	energy = clamp(energy, 0, 100)

	if hunger <= 0:
		die("Starvation")
	if warmth <= 0:
		die("Hypothermia")
	if energy <= 0:
		die("Exhaustion")

	update_ui()

# ---------------------------------------------------------
# BEDROOM FUNCTIONS
# ---------------------------------------------------------

func start_sleeping():
	sleeping = true

func stop_sleeping():
	sleeping = false

func light_fireplace():
	if holding_wood:
		holding_wood = false
		fireplace_lit = true
		fireplace_timer = FIREPLACE_BURN_TIME

func extinguish_fireplace():
	fireplace_lit = false
	fireplace_timer = 0.0

# ---------------------------------------------------------
# FRONT DOOR FUNCTIONS
# ---------------------------------------------------------

func equip_tools():
	if is_holding_item():
		return
	holding_tools = true

func place_bait():
	if holding_cooked_food:
		holding_cooked_food = false
		survival_score += 1

# ---------------------------------------------------------
# OUTSIDE FUNCTIONS
# ---------------------------------------------------------

func collect_raw_food():
	if is_holding_item():
		return
	if holding_tools:
		holding_tools = false
		holding_raw_food = true

func collect_wood():
	if is_holding_item():
		return
	if holding_tools:
		holding_tools = false
		holding_wood = true

# ---------------------------------------------------------
# KITCHEN FUNCTIONS
# ---------------------------------------------------------

func start_cooking():
	if holding_raw_food and not cooking and not cooking_ready:
		holding_raw_food = false
		cooking = true
		cooking_timer = COOK_TIME

func finish_cooking():
	cooking = false
	cooking_ready = true

func collect_cooked_food():
	if cooking_ready and not is_holding_item():
		cooking_ready = false
		holding_cooked_food = true

func add_hunger(amount: float):
	hunger += amount
	hunger = clamp(hunger, 0, 100)

func eat_food():
	if holding_cooked_food:
		holding_cooked_food = false
		add_hunger(50.0)

func start_crafting():
	if holding_wood and not crafting and not crafting_ready:
		holding_wood = false
		crafting = true
		crafting_timer = CRAFT_TIME

func finish_crafting():
	crafting = false
	crafting_ready = true

func collect_plank():
	if crafting_ready and not is_holding_item():
		crafting_ready = false
		holding_plank = true

# ---------------------------------------------------------
# DAY EVALUATION & DEATH
# ---------------------------------------------------------

func reinforce_door():
	if holding_plank:
		holding_plank = false
		survival_score += 1

func evaluate_day():
	if survival_score < 3:
		die("You were not prepared for the night.")
	else:
		print("You survived the day!")
		bigcounter_timer = BIGCOUNTER_TIME

func die(reason: String):
	print("You died: %s" % reason)
	get_tree().change_scene_to_file("res://menu/menu.tscn")

# ---------------------------------------------------------
# UI UPDATE
# ---------------------------------------------------------

func update_ui():
	hunger_bar.value = hunger
	warmth_bar.value = warmth
	energy_bar.value = energy
	day_timer_label.text = "Day Timer: " + str(int(bigcounter_timer))

	if holding_wood:
		inventory_label.text = "Inventory: Wood"
	elif holding_raw_food:
		inventory_label.text = "Inventory: Raw Food"
	elif holding_cooked_food:
		inventory_label.text = "Inventory: Cooked Food"
	elif holding_plank:
		inventory_label.text = "Inventory: Plank"
	elif holding_tools:
		inventory_label.text = "Inventory: Tools"
	else:
		inventory_label.text = "Inventory: None"

	if current_room == "kitchen":
		cooking_ready_label.text = "Cooking Ready: " + ("Yes" if cooking_ready else "No")
		crafting_ready_label.text = "Crafting Ready: " + ("Yes" if crafting_ready else "No")
	else:
		cooking_ready_label.text = ""
		crafting_ready_label.text = ""
