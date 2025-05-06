extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"

#func _ready() -> void:
	

var interact: Callable = func():
	
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.emit_signal("interaction_area_exited", self)
	InteractionManager.unregister_area(self)
