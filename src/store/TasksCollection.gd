extends Node

signal TASK_CREATED(task)
signal TASK_UPDATED(task)
signal TASK_DELETED(task)
signal TASK_LIST_UPDATED

var TaskList: Array = []

func createTask(taskName = "Task") -> void:
	var task = TaskData.new(OS.get_unix_time(), taskName, 0)
	TaskList.append(task)
	emit_signal("TASK_CREATED", task)

func getTaskList() -> Array:
	return TaskList.duplicate(true)

func setTaskList(taskList: Array):
	TaskList = taskList
	emit_signal("TASK_LIST_UPDATED")

func getTaskById(id: int) -> TaskData:
	var result
	for task in TaskList:
		if task.getId() == id:
			result = task
	return result

func updateTask(task: TaskData) -> void:
	var listCopy = getTaskList()
	var index = 0
	for item in listCopy:
		if item.id == task.id:
			listCopy[index] = task
			emit_signal("TASK_UPDATED", item)
		index += 1
	setTaskList(listCopy)

func deleteTask(id: int) -> void:
	var listCopy = getTaskList()
	var index = 0
	for item in listCopy:
		if  item.id == id:
			listCopy.remove(index)
			emit_signal("TASK_DELETED", item)
		index += 1
	setTaskList(listCopy)
	
