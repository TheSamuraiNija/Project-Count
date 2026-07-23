extends Node2D

func _ready():
	print("Opened")
	start()
	
func start():
	stats.time = 250
	$Timer.wait_time = stats.time
	print($Timer.wait_time)
	pass

func _on_hunger_test_pressed() -> void:
	stats.hunger_decay()
	status_update()
func _on_cold_test_pressed() -> void:
	stats.cold_decay()
	status_update()
func _on_sleep_test_pressed() -> void:
	stats.sleep_decay()
	status_update()

func hunger_update(): 
	$HungerUI.text = "Hunger: " + str(stats.hunger)

func _on_timer_timeout() -> void:
	print("Time Out")

func health_update():
		$HealthUI.text = "Health: " + str(stats.health)
func cold_update():
		$ColdUI.text = "Cold: " + str(stats.cold)
func sleep_update():
		$SleepUI.text ="Sleep:" +str(stats.sleep)
func sanity_update():
		$SanityUI.text ="Sanity:" +str(stats.sanity)
func status_update():
	hunger_update()
	health_update()
	cold_update()
	sleep_update()
	sanity_update()

func _on_check_status_pressed() -> void:
	health_update()
	stats.check_status()
	
	
