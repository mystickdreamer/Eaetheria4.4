extends EnemyState
class_name EnemyStateGetHit

@export var anim_name: String = "hit"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 100.0 

@export_category("AI")
@export var next_state: EnemyState

var _animation_finished:bool = false
var damagePosition: Vector2
var _direction: Vector2

func init() -> void:
	enemy.enemy_damaged.connect(onEnemyDamaged)
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#What happens when enters the state 
func enter()->void:
	enemy.invulnerable = true
	_animation_finished = false
	_direction = enemy.global_position.direction_to(damagePosition)
	enemy.setDirection(_direction)
	enemy.velocity = _direction * -knockback_speed
	
	enemy.updateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(onAnimationFinished)
	pass
	
	#What happoens when exiting the state
func exit()->void:
	enemy.animation_player.animation_finished.disconnect(onAnimationFinished)
	enemy.invulnerable = false
	pass
	
	#What happens during the _process update in this state
func process(_delta: float)->EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null
	
	#What happens during the physics process in this state 
func physics( _delta : float) ->EnemyState:
	return null

func onEnemyDamaged(hurt_box: HurtBox)->void:
	damagePosition = hurt_box.global_position
	state_machine.changeState(self)
	
func onAnimationFinished(_a: String)->void:
	_animation_finished = true
