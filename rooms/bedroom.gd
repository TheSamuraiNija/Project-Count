extends Node2D

var gameplay

func _on_fireplaceButton_pressed():
	if gameplay != null:
		gameplay.light_fireplace()

func _on_bedButton_button_down():
	if gameplay != null:
		gameplay.start_sleeping()

func _on_bedButton_button_up():
	if gameplay != null:
		gameplay.stop_sleeping()

func _on_leftButton_pressed():
	if gameplay != null:
		gameplay.load_room("frontDoor")

func _on_rightButton_pressed():
	return

func _on_youButton_pressed() -> void:
	if gameplay != null:
		gameplay.eat_food()

func _on_windowButton_pressed() -> void:
	if gameplay != null:
		gameplay.reinforce_window_named("bedroom_window")

func _on_trashButton_pressed() -> void:
	if gameplay != null:
		gameplay.trash_item()
