extends PopupDialog

onready var TextInput = $"DialogBackground/LineEdit"

func _on_AddTimerBtn_pressed() -> void:
	self.show_modal()

func _on_CancelBtn_pressed() -> void:
	if self.visible:
		self.hide()

func _on_OkBtn_pressed() -> void:
	var text = TextInput.text
	Tasks.createTask(text)
	if self.visible:
		self.hide()

func _on_AddTimerDialog_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if self.visible:
			self.hide()
