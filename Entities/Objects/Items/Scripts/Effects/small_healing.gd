extends ItemEffect
class_name ItemEffectHeal1

@export var heal_amount: int = 1
@export var sound: AudioStream


func use()->void:
	if PlayerManager.player.hp + heal_amount < PlayerManager.player.max_hp:
		PlayerManager.player.modifyHealth(heal_amount)
		#playsound
	else:
		PlayerManager.player.hp = PlayerManager.player.max_hp
	pass
