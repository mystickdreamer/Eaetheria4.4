extends EnemyState
class_name EnemyStateWander

@export var anim_name: String = "walk"
@export var wander_speed: float = 20.0

@export_category("AI")
@export var state_animation_duration: float = 1.0
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

func init() -> void:
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#What happens when enters the state 
func enter()->void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	var rand = randi_range(0, 3)
	_direction = enemy.DIR_4[ rand ]
	enemy.velocity = _direction * enemy.speed
	enemy.setDirection(_direction)
	enemy.updateAnimation(anim_name)
	pass
	
	#What happoens when exiting the state
func exit()->void:
	pass
	
	#What happens during the _process update in this state
func process(_delta: float)->EnemyState:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
	
	#What happens during the physics process in this state 
func physics( _delta : float) ->EnemyState:
	return null
