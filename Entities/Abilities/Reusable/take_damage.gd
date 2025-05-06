extends Area2D
class_name TakeDamageBox


signal damaged(damage: int)




func takeDamage(damage: int)->void:
	var damage_mod = damage
	if get_parent().is_in_group("Monster"):
		var evasion_roll = get_parent().evasionRoll(get_parent().evasion, get_parent().agility, get_parent().evasion_penalty, get_parent().evasion_bonus)
		if evasion_roll >= damage_mod:
			damage_mod = 0
		else:
			var armor_roll = get_parent().get_armor_defense(get_parent().armor_skill, get_parent().armor_bonus, get_parent().endurance, get_parent().armor_extra_bonus)
			if armor_roll < 0:
				armor_roll = 0
			damage_mod -= armor_roll
			if damage_mod <= 0:
				damage_mod = 0
			PlayerManager.player.skill_success_xp = damage_mod
			PlayerManager.player.add_xp_skill()
	else:
		var armor_roll = get_parent().get_armor_defense(get_parent().armor_skill, get_parent().armor_bonus, get_parent().endurance, get_parent().armor_extra_bonus)
		if armor_roll < 0:
				armor_roll = 0
		damage_mod -= armor_roll
		if damage_mod < 0:
			damage_mod = 0
		if damage_mod > 0:
			PlayerManager.player.skill_success_xp = damage_mod
			PlayerManager.player.add_xp_skill()
	damaged.emit(damage_mod)
	pass
