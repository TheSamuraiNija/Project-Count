extends Node2D

func _on_startButton_pressed():
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")

func _on_creditsButton_pressed():
	get_tree().change_scene_to_file("res://menu/credits.tscn")
