extends ItemEffect
class_name BlinkSkill

@export var skill: String = "blink"

func use()->void:
	if PlayerManager.player.mana < 2:
		print("Not enough mana")
		return
	var blink_roll = PlayerManager.player.intelligence + PlayerManager.player.rego + PlayerManager.player.corpus
	var blink_results = globalDiceRoller.roll_dice(blink_roll, 0)
	print("Blink Results: ", blink_results)
	if blink_results < 2:
		print("Blink Failed")
		PlayerManager.player.lastAbility = 4
		PlayerManager.player.mana -= 1
		#exp for failing
		PlayerManager.player.skill_nameXP = "rego"
		PlayerManager.player.skill_success_xp = 1
		PlayerManager.player.add_xp()
		PlayerManager.player.skill_nameXP = "corpus"
		PlayerManager.player.skill_success_xp = 1
		PlayerManager.player.add_xp()
		#People always say you learn more from failing than you do from succeding
		PlayerManager.player.skill_nameXP = "intelligence"
		PlayerManager.player.skill_success_xp = 2
		PlayerManager.player.add_xp()
		#People always say you learn more from failing than you do from succeding
		return
	else:
		PlayerManager.player.useAbility(skill)
		PlayerManager.player.lastAbility = 4
		PlayerManager.player.mana -= 2
		PlayerManager.player.skill_nameXP = "rego"
		PlayerManager.player.skill_success_xp = 2
		PlayerManager.player.add_xp()
		PlayerManager.player.skill_nameXP = "corpus"
		PlayerManager.player.skill_success_xp = 2
		PlayerManager.player.add_xp()
		PlayerManager.player.skill_nameXP = "intelligence"
		PlayerManager.player.skill_success_xp = 1
		PlayerManager.player.add_xp()
		
