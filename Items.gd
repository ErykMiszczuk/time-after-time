extends VBoxContainer

var itemComponent = load("src/components/TaskTimer.tscn")

func _ready() -> void:
	Tasks.connect("TASK_LIST_UPDATED", self, "_on_TASK_LIST_UPDATED_render_items")
	Tasks.connect("TASK_CREATED", self, "_on_TASK_CRUD_render_items")
	Tasks.connect("TASK_UPDATED", self, "_on_TASK_CRUD_render_items")
	Tasks.connect("TASK_DELETED", self, "_on_TASK_CRUD_render_items")

func _on_TASK_LIST_UPDATED_render_items() -> void:
	renderItems()

func _on_TASK_CRUD_render_items(item) -> void:
	print(item)
	renderItems()

func renderItems() -> void:
	var itemList = Tasks.getTaskList()
	if not itemList.empty():
		if self.get_child_count() != itemList.size():
			if self.get_child_count() > 0:
				var children = self.get_children()
				for c in children:
					self.remove_child(c)
					c.queue_free()
			for item in itemList:
				var el = itemComponent.instance()
				el.connect("ELAPSED_TIME_UPDATE", self, "_on_TaskTimer_ELAPSED_TIME_UPDATE")
				el.connect("TASK_DELETE", self, "_on_TaskTimer_TASK_DELETE")
				el.id = int(item.id)
				el.elapsedTime = item.elapsedTime
				el.taskName = item.taskName
				add_child(el)
	else:
		var children = self.get_children()
		for c in children:
			self.remove_child(c)
			c.queue_free()

func _on_TaskTimer_ELAPSED_TIME_UPDATE(id, elapsedTime) -> void:
	var itemsList = Tasks.getTaskList()
	for item in itemsList:
		if item.id == id:
			item.elapsedTime = elapsedTime
	Tasks.setTaskList(itemsList)

func _on_TaskTimer_TASK_DELETE(id):
	Tasks.deleteTask(id)

