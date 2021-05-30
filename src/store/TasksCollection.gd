extends Node

var TaskList: Array = []

func addNewTask(taskName = "Task") -> void:
	var task = TaskData.new(OS.get_unix_time(), taskName, 0)
	TaskList.append(task)

func getTaskList() -> Array:
	return TaskList

func getTaskById(id: int):
	var result
	for task in TaskList:
		if task.getId() == id:
			result = task
	return result
