extends Control

signal ELAPSED_TIME_UPDATE(id, elapsedTime)

onready var TaskNameLabel = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskName"
onready var TaskElapsedTime = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskElapsedTime"
onready var TimerStartStopButton = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton"
onready var Icon = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton/AnimatedSprite"

export var id = 0
export var started = false
export var elapsedTime = 0.0
export var taskName = "Hello there"

func _ready() -> void:
#	self.connect("gui_input", self, "_on_gui_input")
	TaskNameLabel.text = taskName
	TaskElapsedTime.text = _format_time(elapsedTime, false)

func _process(delta: float) -> void:
	if started:
		elapsedTime += delta
		emit_signal("ELAPSED_TIME_UPDATE", id, elapsedTime)
		TaskElapsedTime.text = _format_time(elapsedTime, false)

func _on_TimerStartStopButton_pressed() -> void:
	started = not started

#func _on_gui_input(event) -> void:
#	if event.is_action_pressed("ui_context_menu"):
#		print("CONTEXT MENU ACTIVATED")

func _format_time(time : float, use_milliseconds : bool) -> String:
	var seconds = fmod(time, 60)
	var minutes = fmod(time / 60, 60)
	var hours = fmod(time / 3600, 60)

	if not use_milliseconds:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]

	var milliseconds = fmod(time, 1) * 100

	return "%02d:%02d:%02d:%02d" % [hours, minutes, seconds, milliseconds]

func _on_TaskTimer_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_context_menu"):
		print("CONTEXT MENU ACTIVATED")


func _on_VBoxContainer_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_context_menu"):
		print("CONTEXT MENU ACTIVATED")
