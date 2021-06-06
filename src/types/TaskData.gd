class_name TaskData

var id: int
var taskName: String
var elapsedTime: float

func _init(pid: int, ptaskName: String, pelapsedTime: float) -> void:
	id = pid
	taskName = ptaskName
	elapsedTime = pelapsedTime

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
