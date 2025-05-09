extends Node

const PLAYER = preload("res://Entities/Player/player.tscn")
const INVENTORY_DATA: InventoryData = preload("res://Entities/Player/playerInventory.tres")

var player: Player
var player_spawned: bool = false

signal race_changed

func _ready() -> void:
	addPlayerInstance()
	await get_tree().create_timer(0.5).timeout
	player_spawned = true
	
	

func setAsParent(_p: Node2D)->void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)
	
func unparentPlayer(_p: Node2D)->void:
	_p.remove_child(player)
	
func addPlayerInstance()->void:
	player = PLAYER.instantiate()
	add_child(player)

func setPlayerPosition(newPos: Vector2)->void:
	player.global_position = newPos
