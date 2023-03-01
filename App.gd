extends Control

var timer

func _ready() -> void:
	Tasks.setTaskList(SaveDataService._openTaskList())
	Tasks.connect("TASK_CREATED", self, "_save_list")
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(60)
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	SaveDataService._saveTaskList(Tasks.getTaskList())
	print("LIST SAVED")
	timer.set_wait_time(60)
	timer.start()

func _save_list():
	SaveDataService._saveTaskList(Tasks.getTaskList())
	print("LIST SAVED")
