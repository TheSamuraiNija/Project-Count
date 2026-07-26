extends Node2D

func _ready() -> void:
	$music.play()

func _on_startButton_pressed():
	get_tree().change_scene_to_file("res://gameplay/gameplay.tscn")

func _on_creditsButton_pressed():
	get_tree().change_scene_to_file("res://menu/credits.tscn")


func _on_howtobutton_pressed() -> void:
	$Howtoplay.hide()
	$howtobutton.hide()
