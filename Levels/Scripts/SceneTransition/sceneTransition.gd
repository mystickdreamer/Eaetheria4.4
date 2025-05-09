extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer


func fadeOut()->bool:
	animation_player.play("fadeOut")
	await animation_player.animation_finished
	return true
	
	

	
func fadeIn()->bool:
	animation_player.play("fadeIn")
	await animation_player.animation_finished
	return true
