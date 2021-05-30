class_name TaskData

var id: int
var taskName: String
var elapsedTime: float

func _init(id: int, taskName: String = "Task", elapsedTime: float = 0) -> void:
	id = id
	taskName = taskName
	elapsedTime = elapsedTime

func setId(value: int) -> void:
	self.id = value

func getId() -> int:
	return self.id

func setTaskName(value: String) -> void:
	self.taskName = value

func getTaskName() -> String:
	return self.taskName

func setElapsedTime(value: float) -> void:
	self.elapsedTime = value

func getElapsedTime() -> float:
	return self.elapsedTime
