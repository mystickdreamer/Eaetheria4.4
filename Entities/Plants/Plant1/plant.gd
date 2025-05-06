extends Entity


func _ready():
	$TakeDamage.damaged.connect(take_damage)
	

func take_damage(_damage: int)->void:
	hp -= _damage
	if hp <= 0:
		queue_free()
