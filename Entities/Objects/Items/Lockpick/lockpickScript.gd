extends ItemEffect
class_name LockpickItemScript



func use()->void:
	PlayerManager.player.useAbility("pick")
	var player = PlayerManager.player
	var nearest_area = _get_nearest_interaction_area()
	if nearest_area:
		var container = nearest_area.get_parent()
		if _is_lockable(container):
			if _attempt_lockpick(container):
				container.is_locked = false
				print("Click - lockpicking succedded")
			else:
				print("Lockpicking failed")
		else:
			print("This object cannot be lockpicked")
	else:
		print("No object nearby")
			
	
func _get_nearest_interaction_area()->InteractionArea:
	if InteractionManager.active_areas.size()>0:
		return InteractionManager.active_areas[0]
	return null
func _is_lockable(object: Node2D) -> bool:
	return "is_locked" in object and object.is_locked
func _attempt_lockpick(container: Node2D) -> bool:
	var player = PlayerManager.player
	var thievery_dice = player.thievery + player.agility
	var thievery_results = globalDiceRoller.roll_dice(thievery_dice, 0)
	return thievery_results >= container.locked_dc
