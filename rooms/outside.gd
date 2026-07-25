extends Node2D

var gameplay

func _on_cropsButton_pressed():
	if gameplay != null:
		gameplay.collect_raw_food()

func _on_treesButton_pressed():
	if gameplay != null:
		gameplay.collect_wood()

func _on_downButton_pressed():
	if gameplay != null:
		gameplay.load_room("frontDoor")

func _on_youButton_pressed() -> void:
	if gameplay != null:
		gameplay.eat_food()

func _on_trashButton_pressed() -> void:
	if gameplay != null:
		gameplay.trash_item()
