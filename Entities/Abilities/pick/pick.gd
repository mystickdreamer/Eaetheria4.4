extends Node

var distance = 0
var speed = 200
var cooldown = 2

var lockpick = preload("res://Entities/Abilities/pick/lockpick.tscn")

func execute(s, direction = null):
	if !direction: direction = (s.get_global_mouse_position() - s.position).normalized()
	var look_at = s.get_global_mouse_position()
	
	
	var w = lockpick.instantiate()
	w.position.x = s.position.x + direction.x * 25
	w.position.y = s.position.y + direction.y * 25
	w.configure(s, direction, distance, speed)
	get_node("/root").add_child(w)
