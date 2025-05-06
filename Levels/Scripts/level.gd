extends Node2D
class_name Level

const PICKUP = preload("res://Entities/Objects/item_pickup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.setAsParent(self)
#	LevelManager.levelLoadStarted.connect(freeLevel)

	
func freeLevel()->void:
	PlayerManager.unparentPlayer(self)
	queue_free()
