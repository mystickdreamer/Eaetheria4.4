extends Resource
class_name NPCResource

@export var npc_name: String = ""
@export var npc_class: String = ""

@export var body_sprite: Texture
@export var mouth_sprite: Texture
@export var head_sprite: Texture
@export var eyes_sprite: Texture
@export var hair_sprite: Texture
@export var left_foot_sprite: Texture
@export var right_foot_sprite: Texture
@export var left_hand_sprite: Texture
@export var right_hand_sprite: Texture
@export var left_wing_sprite: Texture
@export var right_wing_sprite: Texture
@export var teeth_sprite: Texture
@export var ears_sprite: Texture
@export var tail_sprite: Texture

@export var body_modulate: Color = Color.WHITE
@export var mouth_modulate: Color = Color.WHITE
@export var head_modulate: Color = Color.WHITE
@export var eyes_modulate: Color = Color.WHITE
@export var hair_modulate: Color = Color.WHITE
@export var foot_modulate: Color = Color.WHITE
@export var hand_modulate: Color = Color.WHITE
@export var wing_modulate: Color = Color.WHITE
@export var teeth_modulate: Color = Color.WHITE
@export var ears_modulate: Color = Color.WHITE
@export var tail_modulate: Color = Color.WHITE

@export var portrait: Texture
@export_range(0.5, 1.8,0.02) var dialog_audio_pitch: float = 1.0
