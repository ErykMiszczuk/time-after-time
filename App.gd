extends Control

var timer

func _ready() -> void:
	Tasks.setTaskList(SaveDataService._openTaskList())
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(60)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	SaveDataService._saveTaskList(Tasks.getTaskList())
	print("LIST SAVED")
	timer.set_wait_time(180)
	timer.start()
