extends CharacterBody2D
class_name BowWeapon

@onready var bow: Sprite2D = $bow



#var varVelocity = Vector2.ZERO

var direction = null
var distance = null
var speed = null
var parent = null
var moved = 0

func _ready() -> void:
	PlayerManager.player.attack_skill = PlayerManager.player.weapon_skill
	PlayerManager.player.attack_skill2 = PlayerManager.player.weapon_damage
	PlayerManager.player.attack_stat = PlayerManager.player.weapon_stat
	PlayerManager.player.skill1 = PlayerManager.player.weapon_skill_name
	PlayerManager.player.skill_stat = PlayerManager.player.weapon_stat_name
	bow.texture = PlayerManager.player.weapon_sprite
	
	

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
	
