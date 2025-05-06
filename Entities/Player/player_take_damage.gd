extends Area2D
class_name PlayerTakeDamageBox

var gp = get_parent()
signal damaged(damage: int)




func takeDamage(damage: int)->void:
	var damage_mod = damage
	var sucXP
	var evasion_roll = PlayerManager.player.evasionRoll(PlayerManager.player.evasion, PlayerManager.player.agility, PlayerManager.player.evasion_penalty, PlayerManager.player.evasion_bonus)
	if evasion_roll >= damage_mod:
		sucXP = evasion_roll - damage_mod
		damage_mod = 0
	if sucXP > 0:
			PlayerManager.player.skill_success_xp = sucXP
			PlayerManager.player.skill1 = "evasion"
			PlayerManager.player.add_xp_skill()
	else:
		var armor_roll = PlayerManager.player.get_armor_defense(PlayerManager.player.armor_skill, PlayerManager.player.armor_bonus, PlayerManager.player.endurance, PlayerManager.player.armor_extra_bonus)
		damage_mod -= armor_roll
		if damage_mod <= 0:
			damage_mod = 0
#	gp.apply_damage(damage_mod)
		PlayerManager.player.skill_success_xp = damage_mod
		PlayerManager.player.add_xp_skill()
	damaged.emit(damage_mod)
	pass
