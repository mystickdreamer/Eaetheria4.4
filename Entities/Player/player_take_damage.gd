extends Area2D
class_name PlayerTakeDamageBox

var gp = get_parent()
signal player_damaged(damage: int)




func playerTakeDamage(damage: int)->void:
	var damage_mod = damage
	var sucXP
	var evasion_roll = PlayerManager.player.evasionRoll(PlayerManager.player.evasion, PlayerManager.player.agility, PlayerManager.player.evasion_penalty, PlayerManager.player.evasion_bonus)
	if evasion_roll >= damage_mod:
		sucXP = evasion_roll - damage_mod
		damage_mod = 0
		if sucXP > 0:
				PlayerManager.player.skill_success_xp = sucXP
												#skill1, skill2, skill_stat
				PlayerManager.player.skill1 = "evasion"
				PlayerManager.player.skill_stat = "agility"
				PlayerManager.player.add_xp_skill()
	else:
		var armor_roll = PlayerManager.player.get_armor_defense(PlayerManager.player.armor_skill, PlayerManager.player.armor_bonus, PlayerManager.player.endurance, PlayerManager.player.armor_extra_bonus)
		if armor_roll > damage_mod:
			sucXP = armor_roll - damage_mod
			PlayerManager.player.skill_success_xp = sucXP
															#skill1, skill2, skill_stat
			PlayerManager.player.skill1 = PlayerManager.player.armor_skill_name
			PlayerManager.player.skill_stat = "endurance"
			PlayerManager.player.add_xp_skill()
		elif armor_roll < damage_mod and armor_roll > -1:
			PlayerManager.player.skill_success_xp = 1
															#skill1, skill2, skill_stat
			PlayerManager.player.skill1 = PlayerManager.player.armor_skill_name
			PlayerManager.player.skill_stat = "endurance"
			PlayerManager.player.add_xp_skill()
		else:
			print("No XP given due to botch")
		damage_mod -= armor_roll
		if damage_mod <= 0:
			damage_mod = 0
			

	player_damaged.emit(damage_mod)
	pass
