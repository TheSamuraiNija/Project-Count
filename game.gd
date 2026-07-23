extends Node2D

func _on_hunger_test_pressed() -> void:
	stats.hunger_decay()

func hunger_update(_delta): 
	$Label.text = stats.hunger
