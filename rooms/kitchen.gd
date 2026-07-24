extends Node2D

var gameplay

func _on_stoveButton_pressed():
	if gameplay == null:
		return
	if gameplay.cooking_ready:
		gameplay.collect_cooked_food()
		return
	gameplay.start_cooking()

func _on_workbenchButton_pressed():
	if gameplay == null:
		return
	if gameplay.crafting_ready:
		gameplay.collect_plank()
		return
	gameplay.start_crafting()

func _on_rightButton_pressed():
	if gameplay != null:
		gameplay.load_room("frontDoor")

func _on_youButton_pressed() -> void:
	if gameplay != null:
		gameplay.eat_food()


func _on_windowButton_pressed() -> void:
	if gameplay != null:
		gameplay.reinforce_window_named("kitchen_window_1")


func _on_windowButton_2_pressed() -> void:
	if gameplay != null:
		gameplay.reinforce_window_named("kitchen_window_2")
