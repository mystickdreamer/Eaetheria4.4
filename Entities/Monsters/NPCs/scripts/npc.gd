@icon("res://Entities/Monsters/NPCs/icons/npc.svg")
extends Entity
class_name NPC

signal behavior_enabled

var state: String = "idle"
var direction: Vector2 = Vector2.DOWN
var direction_name :String = "down"

@export var npc_resource: NPCResource

@onready var left_wing: Sprite2D = $bodyparts/left_wing
@onready var right_wing: Sprite2D = $bodyparts/right_wing
@onready var body: Sprite2D = $bodyparts/body
@onready var head: Sprite2D = $bodyparts/head
@onready var mouth: Sprite2D = $bodyparts/mouth
@onready var eyes: Sprite2D = $bodyparts/eyes
@onready var hair: Sprite2D = $bodyparts/hair
@onready var left_foot: Sprite2D = $bodyparts/left_foot
@onready var right_foot: Sprite2D = $bodyparts/right_foot
@onready var left_hand: Sprite2D = $bodyparts/left_hand
@onready var right_hand: Sprite2D = $bodyparts/right_hand
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	#setup NPC
	pass
	
func setup_npc()->void:
	if npc_resource:
		left_wing.texture = npc_resource.left_wing_sprite
		right_wing.texture = npc_resource.right_wing_sprite
		body.texture = npc_resource.body_sprite
		head.texture = npc_resource.head_sprite
		mouth.texture = npc_resource.mouth_sprite
		eyes.texture = npc_resource.eyes_sprite
		hair.texture = npc_resource.hair_sprite
		left_foot.texture = npc_resource.left_foot_sprite
		right_foot.texture = npc_resource.right_foot_sprite
		left_hand.texture = npc_resource.left_hand_sprite
		right_hand.texture = npc_resource.right_hand_sprite
		
	pass
