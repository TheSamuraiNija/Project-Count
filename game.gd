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
	hunger_update()
	health_update()

func hunger_update(): 
	$HungerUI.text = "Hunger: " + str(stats.hunger)

func _on_timer_timeout() -> void:
	print("Time Out")

func health_update():
		$HealthUI.text = "Health: " + str(stats.health)


func _on_check_status_pressed() -> void:
	health_update()
	stats.check_status()
