extends Node2D

func _ready():
	print("Opened")
	start()
	
func start():
	$Timer.wait_time = stats.time
	print($Timer.wait_time)
	pass

func _on_hunger_test_pressed() -> void:
	stats.hunger_decay()

func hunger_update(_delta): 
	$Label.text = stats.hunger

func _on_timer_timeout() -> void:
	print("Time Out")
