extends Node
class_name EnemyState

#Stores refrence to enemy
var enemy: Enemy
var state_machine: EnemyStateMachine


func init() -> void:
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#What happens when enters the state 
func enter()->void:
	pass
	
	#What happoens when exiting the state
func exit()->void:
	pass
	
	#What happens during the _process update in this state
func process(_delta: float)->EnemyState:
	return null
	
	#What happens during the physics process in this state 
func physics( _delta : float) ->EnemyState:
	return null
