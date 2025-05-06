extends CharacterBody2D
class_name TEnemy

signal direction_changed( new_direction: Vector2)
signal enemy_damaged(hurt_box: HurtBox)
signal enemy_destroyed(hurt_box: HurtBox)

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

@export var hp: int = 5
@export var evadeDice: int = 1
@export var soakDice: int = 1
@export var damageDice: int = 1

var cardinal_direction: Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var invulnerable: bool = false
var player: Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine



func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
#	hit_box.damaged.connect(takeDamage)
	pass
	
func _process(_delta) -> void:
	
	pass
	
func _physics_process(_delta):
	move_and_slide()
	
func setDirection( new_direction: Vector2) -> bool:
	if direction == new_direction:
		if direction == Vector2.ZERO:
			return false
		#The below does some math to get what direction we are facing when moving
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle( ) / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]

	#If we are already facing a direction, then do nothing
	if new_dir == cardinal_direction:
		return false
	#If we are moving a different direction than we are facing then change direction	
	cardinal_direction = new_dir
	direction_changed.emit( new_dir )
	# Scaling the Sprite up, we need to make sure the sprite keeps the same scale.
	var current_scale = animated_sprite.scale.abs()
	animated_sprite.scale.x = -current_scale.x if cardinal_direction == Vector2.LEFT else current_scale.x
	return true
	
func updateAnimation(state: String)->void:
#	print("Anim direction: ", animDirection())
	animation_player.play( state + animDirection())
	
	
func animDirection()->String:
	if cardinal_direction == Vector2.DOWN:
		return "Down"
	elif cardinal_direction == Vector2.UP:
		return "Up"
	else:
		return "Side"
		
#func takeDamage(hurt_box: HurtBox)->void:
#	if invulnerable == true:
#		return
#	var finalDamage: int = hurt_box.damage
#	var evade = GlobalDiceRoller.roll_dice(self.evadeDice, 0)
#	if evade > finalDamage:
#		finalDamage = 0
#		return
#	else:
#		var damRed = GlobalDiceRoller.roll_dice(self.soakDice, 0)
#		finalDamage -= damRed
#		if finalDamage < 0:
#			finalDamage = 0
#	hp -= finalDamage
#	if hp > 0:
#		enemy_damaged.emit(hurt_box)
#	else:
#		enemy_destroyed.emit(hurt_box)
#	
