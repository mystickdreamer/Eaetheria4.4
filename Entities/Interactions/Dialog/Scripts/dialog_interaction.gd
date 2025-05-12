@tool
@icon("res://Assets/icons/chat_bubbles.svg")
extends Node2D
class_name DialogInteraction

signal player_interacted
signal finished

@onready var interaction_area: InteractionArea = $InteractionArea



@export var enabled: bool = true

var dialog_items: Array[DialogItem]

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if Engine.is_editor_hint():
		return
#	animation_player.play("hide")
	interaction_area.interact = Callable(self, "onInteract")
	
	for c in get_children():
		if c is DialogItem:
			dialog_items.append(c)
			

func onInteract():
	player_interacted.emit()
	await get_tree().process_frame
	await get_tree().process_frame
	DialogSystem.show_dialog(dialog_items)
	DialogSystem.finished.connect(_on_dialog_finished)
	pass
	
func secondSpeak()->void:
	
	pass

func _get_configuration_warnings() -> PackedStringArray:
	#check for dialog items
	if _check_for_dialog_items() == false:
		return ["Requires at least on DialogItem node."]
	else:
		return []
		
	pass
	
func _check_for_dialog_items()->bool:
	for c in get_children():
		if c is DialogItem:
			return true
	return false






func _on_body_entered(body: Node2D) -> void:
	if enabled == false or dialog_items.size() == 0:
		return
	animation_player.play("show")




func _on_body_exited(body: Node2D) -> void:
	if enabled == false or dialog_items.size() == 0:
		return
	animation_player.play("hide")

	
func _on_dialog_finished()->void:
	DialogSystem.finished.disconnect(_on_dialog_finished)
	finished.emit()
