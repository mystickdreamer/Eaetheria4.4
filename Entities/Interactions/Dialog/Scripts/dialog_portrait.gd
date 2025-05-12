@tool
extends Sprite2D
class_name DialogPortrait

var blink: bool = false : set = _set_blink
var open_mouth: bool = false: set = _set_open_mouth
var mouth_open_frames: int = 0
var audio_pitch_base : float = 1.0

@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	DialogSystem.letter_added.connect(check_mouth_open)

func _set_blink(_v: bool)->void:
	blink = _v
func _set_open_mouth(_v:bool)->void:
	if open_mouth != _v:
		
		open_mouth = _v
		update_portrait()
	
func check_mouth_open(l: String)->void:
	if 'aeiouy123456780'.contains(l):
		open_mouth = true
		mouth_open_frames += 3
		audio_stream_player.pitch_scale = randf_range(audio_pitch_base - 0.04, audio_pitch_base + 0.05 )
		audio_stream_player.play()
	elif '.,!?'.contains(l):
		mouth_open_frames = 0
	
	if mouth_open_frames > 0:
		mouth_open_frames -= 1
		
	
	
	if mouth_open_frames == 0:
		if open_mouth == true:
			open_mouth = false
			audio_stream_player.pitch_scale = randf_range(audio_pitch_base - 0.08, audio_pitch_base + 0.02)
			audio_stream_player.play()
	
func update_portrait()->void:
	if open_mouth == true:
		frame = 0
	else:
		frame = 1
