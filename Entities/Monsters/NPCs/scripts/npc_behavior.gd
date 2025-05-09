@icon("res://Entities/Monsters/NPCs/icons/npc_behavior.svg")
extends Node2D
class_name NPCBehavior


var npc: NPC

func _ready() -> void:
	var p = get_parent()
	if p is NPC:
		npc = p as NPC
		#connect to signal
