extends VBoxContainer

var itemComponent = load("TaskTimer.tscn")
var itemList = [] setget setItemList, getItemList

func setItemList(list):
	print("RECEIVED DATA")
	itemList = list
	render_children()
	
func getItemList():
	return itemList
	
func render_children():
	if self.get_child_count() != itemList.size():
		if self.get_child_count() > 0:
			var children = self.get_children()
			for c in children:
				self.remove_child(c)
				c.queue_free()
		for item in itemList:
			var el = itemComponent.instance()
			el.id = item.id
			el.elapsedTime = item.elapsedTime
			el.taskName = item.taskName
			add_child(el)
