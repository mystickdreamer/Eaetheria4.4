extends AnimatedSprite2D

@onready var interaction_area: InteractionArea = $InteractionArea




func _ready() -> void:
	interaction_area.interact = Callable(self, "onInteract")
	
	
func onInteract():
	if self.is_in_group("Human"):
		var new_race = preload("res://Entities/Resources/Races/human.tres")
		PlayerManager.player.race = new_race
		PlayerManager.emit_signal("race_changed")
		
		pass
	elif self.is_in_group("Elf"):
		var new_race = preload("res://Entities/Resources/Races/elf.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Pixie"):
		var new_race = preload("res://Entities/Resources/Races/pixie.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.is_flying = true
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Dwarf"):
		var new_race = preload("res://Entities/Resources/Races/dwarf.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Forged"):
		var new_race = preload("res://Entities/Resources/Races/forged.tres")
		PlayerManager.player.race = new_race
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Gnome"):
		var new_race = preload("res://Entities/Resources/Races/gnome.tres")
		PlayerManager.player.race = new_race
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Goblin"):
		var new_race = preload("res://Entities/Resources/Races/goblin.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Halfling"):
		var new_race = preload("res://Entities/Resources/Races/halfling.tres")
		PlayerManager.player.race = new_race
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("HalfOrc"):
		var new_race = preload("res://Entities/Resources/Races/halforc.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Felarion"):
		var new_race = preload("res://Entities/Resources/Races/tabaxi.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Fellborn"):
		var new_race = preload("res://Entities/Resources/Races/tiefling.tres")
		PlayerManager.player.race = new_race
		PlayerManager.player.vision = Entity.Vision.DarkVis
		PlayerManager.emit_signal("race_changed")
		pass
	elif self.is_in_group("Turtovan"):
		var new_race = preload("res://Entities/Resources/Races/tortle.tres")
		PlayerManager.player.race = new_race
		PlayerManager.emit_signal("race_changed")
		pass
	
	pass
