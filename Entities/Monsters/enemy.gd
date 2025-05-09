extends Entity
class_name Enemy

@export var agility_min: int = 1
@export var agility_max: int = 1

@export var might_min: int = 1
@export var might_max: int = 1

@export var end_min:int = 1
@export var end_max:int = 1

@export var MA_min: int = 0
@export var MA_max: int = 0

@export var evas_min:int = 0
@export var evas_max: int = 0

@export var armor_min:int = 0
@export var armor_max:int = 0

@export var monsterSpeedMin: float = 5.0
@export var monsterSpeedMax: float = 20.0

signal direction_changed( new_direction: Vector2)
#signal enemy_damaged(hurt_box: HurtBox)
#signal enemy_destroyed(hurt_box: HurtBox)

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

var sprite_size: int = 1

var cardinal_direction: Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var invulnerable: bool = false
var player: Player

var monsterVelocity: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
#@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var takeDamage_collision: CollisionShape2D = $TakeDamage/CollisionShape2D
@onready var body_collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	state_machine.initialize(self)
	player = PlayerManager.player
#	hit_box.damaged.connect(takeDamage)
	might = randi_range(might_min, might_max)
	agility = randi_range(agility_min, agility_max)
	endurance = randi_range(end_min, end_max)
	
	martialArts = randi_range(MA_min, MA_max)
	evasion = randi_range(evas_min, evas_max)
	armor_skill = randi_range(armor_min, armor_max)
	
	monsterVelocity = randf_range(monsterSpeedMin, monsterSpeedMax)
	
	var check_size = might + endurance
	if check_size > 2 and check_size < 4:
		sprite_size = 1.5
	elif check_size >= 4:
		sprite_size = 2
		takeDamage_collision.position.y += 10
		body_collision.position.y += 10
	else:
		sprite_size = 1
	animated_sprite.scale = Vector2(sprite_size, sprite_size)
	takeDamage_collision.scale = Vector2(sprite_size, sprite_size)
	body_collision.scale = Vector2(sprite_size, sprite_size)
	
	$TakeDamage.damaged.connect(take_damage)

	
func _process(_delta) -> void:
	
	pass
	
func _physics_process(_delta):
	speed = monsterVelocity
	super._physics_process(_delta)
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
#func take_damage(_damage: int)->void:
	#hp -= _damage
	#if hp <= 0:
		#queue_free()
