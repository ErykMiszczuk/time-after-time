extends Control

onready var TaskNameLabel = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskName"
onready var TaskElapsedTime = $"TaskTimerBackground/HBoxContainer/VBoxContainer/TaskElapsedTime"
onready var TimerStartStopButton = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton"
onready var Icon = $"TaskTimerBackground/HBoxContainer/Container/TimerStartStopButton/AnimatedSprite"

export var started = false
export var elapsedTime = 0.0
export var taskName = "Hello there"

func _ready() -> void:
	TaskNameLabel.text = taskName

func _process(delta: float) -> void:
	if started:
		elapsedTime += delta
		TaskElapsedTime.text = _format_time(elapsedTime, false)

func _on_TimerStartStopButton_pressed() -> void:
	started = not started
	
func _format_time(time : float, use_milliseconds : bool) -> String:
	var hours = time / 360
	var minutes = time / 60
	var seconds = fmod(time, 60)

	if not use_milliseconds:
		return "%02d:%02d:%02d" % [hours, minutes, seconds]

	var milliseconds = fmod(time, 1) * 100

	return "%02d:%02d:%02d:%02d" % [hours, minutes, seconds, milliseconds]
	
