extends Node

const PLAYER = preload("res://Entities/Player/player.tscn")
const INVENTORY_DATA: InventoryData = preload("res://Entities/Player/playerInventory.tres")

var player: Player

signal race_changed

func setAsParent(_p: Node2D)->void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
func unparentPlayer(_p: Node2D)->void:
	_p.remove_child(player)
	
func addPlayerInstance()->void:
	player = PLAYER.instantiate()
	add_child(player)
