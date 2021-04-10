extends VBoxContainer

signal ITEMS_CHANGED(items)

var itemComponent = load("TaskTimer.tscn")
var itemList = [] setget setItemList, getItemList

func setItemList(list):
	itemList = list
	render_children()
	
func getItemList():
	return itemList
	
func render_children():
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
				el.id = int(item.id)
				el.elapsedTime = item.elapsedTime
				el.taskName = item.taskName
				add_child(el)

func _on_TaskTimer_ELAPSED_TIME_UPDATE(id, elapsedTime):
	var listCopy = itemList.duplicate(true)
	for item in listCopy:
		if item.id == id:
			item.elapsedTime = elapsedTime
	emit_signal("ITEMS_CHANGED", listCopy)
