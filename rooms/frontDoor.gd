extends Node2D

var gameplay

func _on_toolsButton_pressed():
	if gameplay != null:
		gameplay.equip_tools()

func _on_baitButton_pressed():
	if gameplay != null:
		gameplay.place_bait()

func _on_upButton_pressed():
	if gameplay != null:
		gameplay.load_room("outside")

func _on_leftButton_pressed():
	if gameplay != null:
		gameplay.load_room("kitchen")
		
func _on_rightButton_pressed():
	if gameplay != null:
		gameplay.load_room("bedroom")

func _on_youButton_pressed() -> void:
	if gameplay != null:
		gameplay.eat_food()

func _on_windowButton_pressed() -> void:
	if gameplay != null:
		gameplay.reinforce_window_named("front_window_1")

func _on_windowButton_2_pressed() -> void:
	if gameplay != null:
		gameplay.reinforce_window_named("front_window_2")

func _on_trashButton_pressed() -> void:
	if gameplay != null:
		gameplay.trash_item()
