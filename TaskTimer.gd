extends Control

signal ELAPSED_TIME_UPDATE(id, elapsedTime)
signal TASK_DELETE(id)

onready var TaskNameLabel = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskName"
onready var TaskElapsedTime = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskElapsedTime"
onready var TimerStartStopButton = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton"
onready var Icon = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton/AnimatedSprite"

export var id = 0
export var started = false
export var elapsedTime = 0.0
export var taskName = "Hello there"

var isDragged = false
var originalPosition = Vector2()
var mousePosition = Vector2()

func _ready() -> void:
	TaskNameLabel.text = taskName
	TaskElapsedTime.text = _format_time(elapsedTime, false)

func _process(delta: float) -> void:
	if isDragged:
		var pos = get_global_mouse_position()
		var offset = pos.x - mousePosition.x
		offset = clamp(offset, -60, 5)
		var threshold = 60 * 0.75
		if abs(offset) > threshold:
			emit_signal("TASK_DELETE", id)
		else:
			var newPos = Vector2(originalPosition.x + offset, originalPosition.y)
			self.set_position(newPos)
	if started:
		elapsedTime += delta
		emit_signal("ELAPSED_TIME_UPDATE", id, elapsedTime)
		TaskElapsedTime.text = _format_time(elapsedTime, false)

func _on_TimerStartStopButton_pressed() -> void:
	started = not started

func _format_time(time : float, use_milliseconds : bool) -> String:
	var seconds = fmod(time, 60)
	var minutes = fmod(time / 60, 60)
	var hours = fmod(time / 3600, 60)

	if not use_milliseconds:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]

	var milliseconds = fmod(time, 1) * 100

	return "%02d:%02d:%02d:%02d" % [hours, minutes, seconds, milliseconds]

func start_dragging() -> void:
	var mousePos = get_global_mouse_position()
	var elementPos = self.rect_position
	originalPosition = elementPos
	mousePosition = mousePos
	isDragged = true
#	print("Mouse pos: ", mousePos)
#	print("Element pos: ", elementPos)

func end_dragging() -> void:
	self.set_position(originalPosition)
	originalPosition = Vector2()
	mousePosition = Vector2()
	isDragged = false

func _on_VBoxContainer_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_drag"):
		start_dragging()
	if event.is_action_released("ui_drag"):
		end_dragging()
