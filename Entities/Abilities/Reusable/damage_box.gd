extends Area2D
class_name DamageBox

var gp = get_parent()

func _ready():
	area_entered.connect( _area_entered)
	
	pass
	
func _area_entered(a: Area2D)->void:
	print(a, "takeDamage Box entered")
	if a is TakeDamageBox:
		print("Area is a takeDamage box ")
		print(get_parent())
		print(get_parent().get_parent())
#		var damage_dice = gp.attack_skill + gp.attack_skill2 + gp.attack_stat
#		print(damage_dice)
#		var damage = globalDiceRoller.roll_dice(damage_dice, 0)
#		print(damage)
#		a.takeDamage(damage)
#		gp.attack_skill = 0
#		gp.attack_skill2 = 0
#		gp.attack_stat = 0
	pass
