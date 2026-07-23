extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")
	stats.initalize()
	# This does not work becuase I have no idea
	$MenuTap
