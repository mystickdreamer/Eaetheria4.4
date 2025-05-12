@tool
@icon("res://Entities/Monsters/NPCs/icons/npc.svg")
extends Entity
class_name NPC

signal behavior_enabled

var state: String = "idle"
var direction: Vector2 = Vector2.DOWN
var direction_name :String = "side"
var do_behavior_enabled: bool = true


@export var npc_resource: NPCResource : set = _set_npc_resource

@onready var left_wing: Sprite2D = $left_wing
@onready var right_wing: Sprite2D = $right_wing
@onready var body: Sprite2D = $body
@onready var head: Sprite2D = $head
@onready var mouth: Sprite2D = $mouth
@onready var eyes: Sprite2D = $eyes
@onready var hair: Sprite2D = $hair
@onready var left_foot: Sprite2D = $left_foot
@onready var right_foot: Sprite2D = $right_foot
@onready var left_hand: Sprite2D = $left_hand
@onready var right_hand: Sprite2D = $right_hand
@onready var ears: Sprite2D = $ears
@onready var tail: Sprite2D = $tail

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	setup_npc()
	if Engine.is_editor_hint():
		return
		
	behavior_enabled.emit()
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func update_animation()->void:
	animation_player.play(state + "_side") #+ direction_name)
	pass
	
func update_direction(target_position: Vector2)->void:
	direction = global_position.direction_to(target_position)
#	update_direction_name()
#	if direction_name == "side" and direction.x < 0:
	if direction.x < 0:
		left_wing.flip_h = true
		right_wing.flip_h = true
		right_hand.flip_h = true
		left_hand.flip_h = true
		right_foot.flip_h = true
		left_foot.flip_h = true
		body.flip_h = true
		head.flip_h = true
		mouth.flip_h = true
		eyes.flip_h = true
		hair.flip_h = true
		ears.flip_h = true
		tail.flip_h = true
	else:
		left_wing.flip_h = false
		right_wing.flip_h = false
		right_hand.flip_h = false
		left_hand.flip_h = false
		right_foot.flip_h = false
		left_foot.flip_h = false
		body.flip_h = false
		head.flip_h = false
		mouth.flip_h = false
		eyes.flip_h = false
		hair.flip_h = false
		ears.flip_h = false
		tail. flip_h = false
	
#func update_direction_name()->void:
#	var threshold : float = 0.45
#	if direction.y < -threshold:
#		direction_name = "up"
#	elif direction.y > threshold:
#		direction_name = "down"
#	elif direction.x > threshold or direction.x < -threshold:
#		direction_name = "side"
	
func setup_npc()->void:
	if npc_resource:
		if left_wing:
			left_wing.texture = npc_resource.left_wing_sprite
		if right_wing:
			right_wing.texture = npc_resource.right_wing_sprite
		if body:
			body.texture = npc_resource.body_sprite
		if head:
			head.texture = npc_resource.head_sprite
		if mouth:
			mouth.texture = npc_resource.mouth_sprite
		if eyes:
			eyes.texture = npc_resource.eyes_sprite
		if hair:
			hair.texture = npc_resource.hair_sprite
		if left_foot:
			left_foot.texture = npc_resource.left_foot_sprite
		if right_foot:
			right_foot.texture = npc_resource.right_foot_sprite
		if left_hand:
			left_hand.texture = npc_resource.left_hand_sprite
		if right_hand:
			right_hand.texture = npc_resource.right_hand_sprite
		if left_wing:
			left_wing.self_modulate = npc_resource.wing_modulate
		if right_wing:
			right_wing.self_modulate = npc_resource.wing_modulate
		if body:
			body.self_modulate = npc_resource.body_modulate
		if head:
			head.self_modulate = npc_resource.head_modulate
		if mouth:
			mouth.self_modulate = npc_resource.mouth_modulate
		if eyes:
			eyes.self_modulate = npc_resource.eyes_modulate
		if hair:
			hair.self_modulate = npc_resource.hair_modulate
		if left_foot:
			left_foot.self_modulate = npc_resource.foot_modulate
		if right_foot:
			right_foot.self_modulate = npc_resource.foot_modulate
		if left_hand:
			left_hand.self_modulate = npc_resource.hand_modulate
		if right_hand:
			right_hand.self_modulate = npc_resource.hand_modulate
		
	pass

func _set_npc_resource(_npc: NPCResource)->void:
	npc_resource = _npc
	setup_npc()
	pass

func gather_interactables()->void:
	for c in get_children():
		if c is DialogInteraction:
			c.player_interacted.connect(_on_player_interacted)
			c.finished.connect(_on_interaction_finished)
			
func _on_player_interacted()->void:
	update_direction(PlayerManager.player.global_position)
	state = "idle"
	velocity = Vector2.ZERO
	update_animation()
	do_behavior_enabled = false
	
func _on_interaction_finished()->void:
	state = "idle"
	update_animation()
	do_behavior_enabled = true
	behavior_enabled.emit()
	
	pass
