extends Node

func saveTaskList(taskList: Array) -> void:
	var f: File = File.new()
	f.open("res://taskList.json", File.WRITE)
	f.store_line(to_json(taskList))
	f.close()

func openTaskList() -> Array:
	var f: File = File.new()
	var taskList: Array = []
	f.open("res://taskList.json", File.READ)
	if f.get_len() <= 0:
		taskList = []
	else:
		taskList = parse_json(f.get_line())
	f.close()
	return taskList
