extends Node

var is_paused: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if is_paused == false:
		if DialogSystem.is_active:
			return
	pass
