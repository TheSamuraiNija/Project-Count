extends Node2D

func _on_button_pressed() -> void:
	stats.check_status()
	stats.cold += 25
	if stats.cold > 100:
		stats.cold = 100
	print("you warmed yourself up")
	stats.time - 5
	stats.check_status()

	
