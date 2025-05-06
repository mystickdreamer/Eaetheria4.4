extends Area2D
class_name PlayerDamageBox

func _ready():
	area_entered.connect( _area_entered)
	
	pass
	
func _area_entered(a: Area2D)->void:
	print(a, "takeDamage Box entered")
	if a is TakeDamageBox:
		print("Area is a takeDamage box ")
		print("attack skill: ", PlayerManager.player.attack_skill)
		print("attack skill2: ", PlayerManager.player.attack_skill2)
		print("staTl: ", PlayerManager.player.attack_stat)
		var damage_dice = PlayerManager.player.attack_skill + PlayerManager.player.attack_skill2 + PlayerManager.player.attack_stat
		print(damage_dice)
		var damage = globalDiceRoller.roll_dice(damage_dice, 0)
		print(damage)
		a.takeDamage(damage)
		PlayerManager.player.attack_skill = 0
		PlayerManager.player.attack_skill2 = 0
		PlayerManager.player.attack_stat = 0
	pass
