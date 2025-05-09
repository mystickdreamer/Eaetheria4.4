extends Entity

@onready var left_wings: AnimatedSprite2D = $AnimatedSprites/LeftWings
@onready var right_wings: AnimatedSprite2D = $AnimatedSprites/RightWings
@onready var bodies: AnimatedSprite2D = $AnimatedSprites/Bodies
@onready var heads: AnimatedSprite2D = $AnimatedSprites/Heads
@onready var eyes: AnimatedSprite2D = $AnimatedSprites/Eyes
@onready var hairs: AnimatedSprite2D = $AnimatedSprites/Hairs
@onready var left_feet: AnimatedSprite2D = $AnimatedSprites/LeftFeet
@onready var right_feet: AnimatedSprite2D = $AnimatedSprites/RightFeet
@onready var left_hands: AnimatedSprite2D = $AnimatedSprites/LeftHands
@onready var right_hands: AnimatedSprite2D = $AnimatedSprites/RightHands

@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum WANDER {Yes, No}
@export var wander: WANDER = WANDER.No

@export var npc_name: String = "NPC"
@export var dialog: String = "Hail and well met."
@export var hair_type: String = "1"
@export var head_type: String = "1"
@export var body_type: String = "1"
@export var eye_type: String = "1"
@export var feet_type: String = "1"
@export var hand_type: String = "1"
@export var mouth_type: String = "1"
@export var wing_type: String = "none"

@export var head_tint: Color = Color.WHITE
@export var hair_tint: Color = Color.WHITE
@export var body_tint: Color = Color.WHITE
@export var eye_tint: Color = Color.WHITE
@export var feet_tint: Color = Color.WHITE
@export var hand_tint: Color = Color.WHITE
@export var mouth_tint: Color = Color.WHITE
@export var wing_tint: Color = Color.WHITE

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	heads.self_modulate = head_tint
