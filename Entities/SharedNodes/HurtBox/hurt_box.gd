extends Area2D
class_name HurtBox

var player: Player

var damage: int = 0


func _ready():
	area_entered.connect(areaEntered)
	

func areaEntered(a: Area2D)->void:
	if a is HitBox:
		if get_parent().is_in_group("Monsters"):
			print("Confirmed in Monsters group")
			damage = GlobalDiceRoller.roll_dice(get_parent().damageDice, 0)
			a.takeDamage(self)
		elif get_parent().get_parent().is_in_group("Player"):
			#We want to directly call the players attack skill here. 
			damage = GlobalDiceRoller.roll_dice(get_parent().get_parent().getAttackSkill(), 0)
			print("Player Damage: ", damage)
			a.takeDamage(self)
		else:
#			damage = GlobalDiceRoller.roll_dice(get_parent().damageDice, 0)
			a.takeDamage(self)
	pass
