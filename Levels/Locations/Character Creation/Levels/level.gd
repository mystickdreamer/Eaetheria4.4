extends Node2D
class_name Level




func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.setAsParent(self)
	LevelManager.level_load_started.connect(free_level)
	pass
func free_level()->void:
	PlayerManager.unparentPlayer(self)
	queue_free()
