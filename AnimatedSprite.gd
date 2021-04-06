extends AnimatedSprite

export var started = false

func _on_TimerStartStopButton_pressed() -> void:
	started = not started
	self.frame = int(started)
