extends EnemyState
class_name EnemyStateIdle

@export var anim_name: String = "idle"

@export_category("AI")
@export var state_duration_min: float = 1.0
@export var state_duration_max: float = 2.0
@export var next_state: EnemyState


var _timer: float = 0.0

func init() -> void:
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#What happens when enters the state 
func enter()->void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
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
