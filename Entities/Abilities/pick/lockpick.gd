extends CharacterBody2D


#var varVelocity = Vector2.ZERO

var direction = null
var distance = null
var speed = null
var parent = null
var moved = 0

func configure(s = null, my_direction = null, my_distance = null, my_speed = null):
	parent = s
	direction = my_direction
	distance = my_distance
	speed = my_speed
	look_at(s.position + my_direction)
	
	#spawns then moves in direction
func _physics_process(delta: float) -> void:
	if moved < distance: move()
	if moved >= distance:
		if PlayerManager.player.lastAbility == 0:
			self.queue_free()
		
func move():
	moved += 1
	velocity = Vector2.ZERO
	
	velocity.x = direction.x
	velocity.y = direction.y
	velocity = velocity.normalized()
	velocity = velocity * speed
	move_and_slide()
	
