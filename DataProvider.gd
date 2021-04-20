extends Control

var timer

class Task:
	var id: int = 0
	var taskName: String = ""
	var elapsedTime: float = 0

export var listOfTasks = []
onready var ItemsListComponent = $"AppView/ScrollList/Items"

func _ready() -> void:
	open_task_list()
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.set_wait_time(180)
	add_child(timer)
	timer.start()
	ItemsListComponent.connect("ITEMS_CHANGED", self, "_on_ItemsListComponent_ITEMS_CHANGED")
	ItemsListComponent.setItemList(listOfTasks)

func _on_ItemsListComponent_ITEMS_CHANGED(items):
	listOfTasks = items
	if items.size() == 0:
		print("DELETED ALL ITEMS")
	ItemsListComponent.setItemList(listOfTasks)

func _on_AddTimerDialog_ADD_NEW_TASK(taskName) -> void:
	var task = {
		"id": OS.get_unix_time(),
		"taskName": taskName,
		"elapsedTime": 0
	} 
	listOfTasks.append(task)
	ItemsListComponent.setItemList(listOfTasks)
	save_task_list()

func _on_timer_timeout():
	save_task_list()
	print("LIST SAVED")
	timer.set_wait_time(180)
	timer.start()

func save_task_list():
	var f = File.new()
	f.open("res://taskList.json", File.WRITE)
	f.store_line(to_json(listOfTasks))
	f.close()

func open_task_list():
	var f = File.new()
	f.open("res://taskList.json", File.READ)
	if f.get_len() <= 0:
		listOfTasks = []
	else:
		listOfTasks = parse_json(f.get_line())
	f.close()


