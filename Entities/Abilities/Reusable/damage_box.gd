extends Area2D
class_name DamageBox



func _ready():
	area_entered.connect( _area_entered)
	
	pass
	
func _area_entered(a: Area2D)->void:
	print(a, "takeDamage Box entered")
	if a is PlayerTakeDamageBox:
		print("Area is a takeDamage box ")
		print(get_parent())
		print(get_parent().get_parent())
#		var damage_dice = get_parent().martialArts + get_parent().agility
#		print(damage_dice)
#		var damage = globalDiceRoller.roll_dice(damage_dice, 0)
#		print(damage)
		var damage = 20
		a.playerTakeDamage(damage)
