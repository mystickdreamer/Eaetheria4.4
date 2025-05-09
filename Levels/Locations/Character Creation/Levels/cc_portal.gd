extends AnimatedSprite2D

func _ready() -> void:
	PlayerManager.connect("race_changed", Callable(self, "_on_race_changed"))
	self.visible = false



func _on_race_changed():
	if PlayerManager.player.race.race_name != "None":
		self.scale = Vector2(1, 1)
		self.visible = true
	else:
		self.scale = Vector2(0, 0)
		self.visible = false
