extends Node

@export var sneak_color: Color = Color.WHITE


func execute(s):
#	var debug_label = s.get_node("DebugLabel")

	if s.sneaking == false:
		print("Started sneaking")
#		if debug_label:
#			debug_label.text += "Stealth: " + stre(s.stealth)
		var stealth: int = s.stealth + s.agility
#		if globalDiceRoller != null and globalDiceRoller.has_method("roll_dice"):
		s.sneakRoll = globalDiceRoller.roll_dice(s.stealth, 0)
		print("SneakRoll: ", s.sneakRoll)
#			if debug_label:
#				debug_label.text += "\nglobalDiceRoller is not defined or does not have roll_dice method"
		PlayerManager.player.modulate = sneak_color
		s.sneaking = true
	else:
		PlayerManager.player.modulate = Color.WHITE
		s.sneaking = false
		s.sneakRoll = 0
		print("Stopped Sneaking")
