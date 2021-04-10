extends Control

class Task:
	var id: int = 0
	var taskName: String = ""
	var elapsedTime: float = 0

export var listOfTasks = [{
	"id": 1,
	"taskName": "10 skór dla ganra",
	"elapsedTime": 3600
}, 
{
	"id": 2,
	"taskName": "Chleb dla montery",
	"elapsedTime": 3600
},
{
	"id": 3,
	"taskName": "Mięso dla montery",
	"elapsedTime": 3600
},
]
onready var ItemsListComponent = $"AppView/ScrollList/Items"

func _ready() -> void:
	ItemsListComponent.connect("ITEMS_CHANGED", self, "_on_ItemsListComponent_ITEMS_CHANGED")
	ItemsListComponent.setItemList(listOfTasks)

func _on_ItemsListComponent_ITEMS_CHANGED(items):
	listOfTasks = items
	ItemsListComponent.setItemList(listOfTasks)

func _on_AddTimerDialog_ADD_NEW_TASK(taskName) -> void:
	var task = Task.new()
	task.id = OS.get_unix_time()
	task.taskName = taskName
	listOfTasks.append(task)
	ItemsListComponent.setItemList(listOfTasks)


