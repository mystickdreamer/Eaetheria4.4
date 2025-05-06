extends Node2D

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
var facingDirection: String
func execute(s, dir):
	var animation_to_play = ""
	s.velocity = Vector2.ZERO
	if dir == "up":
		s.velocity.y -= 1
		facingDirection = "Up"
	if dir == "down":
		s.velocity.y += 1
		facingDirection = "Down"
	if dir == "right":
		s.velocity.x += 1
		facingDirection = "Right"
	if dir == "left":
		s.velocity.x -= 1
		facingDirection = "Left"
		
	s.velocity = s.velocity.normalized() * s.maxSpeed
	s.move_and_slide()
	
	if get_parent().isMoving:
		var walkAnimation = "walk"+facingDirection
		animation_player.play(walkAnimation)
	else:
		var idleAnimation = "idle"+facingDirection
		animation_player.play(idleAnimation)
