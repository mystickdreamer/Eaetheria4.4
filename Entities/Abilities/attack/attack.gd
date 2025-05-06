extends Node


var distance = 0
var ammodistance = PlayerManager.player.weapon_range
var speed = 200
var cooldown = 2

var weapon = preload("res://Entities/Abilities/attack/weapon.tscn")
var ammo = preload("res://Entities/Abilities/attack/ammo.tscn")
var bow = preload("res://Entities/Abilities/attack/bow.tscn")


func execute(s, direction = null):
	if !direction: direction = (s.get_global_mouse_position() - s.position).normalized()
	var look_at = s.get_global_mouse_position()
	
	
	if PlayerManager.player.is_bow:
		var w = bow.instantiate()
		w.position.x = s.position.x + direction.x * 25
		w.position.y = s.position.y + direction.y * 25
		w.configure(s, direction, distance, speed)
		get_node("/root").add_child(w)
		var b = ammo.instantiate()
		b.position.x = s.position.x + direction.x * 25
		b.position.y = s.position.y + direction.y * 25
		b.configure(s, direction, ammodistance, speed)
		get_node("/root").add_child(b)
	else:
		var w = weapon.instantiate()
		w.position.x = s.position.x + direction.x * 25
		w.position.y = s.position.y + direction.y * 25
		w.configure(s, direction, distance, speed)
		get_node("/root").add_child(w)
	
	
