extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var container_inventory_interface: PanelContainer = $ContainerUI/ContainerInventoryInterface
@onready var sprite_2d: Sprite2D = $Sprite2D



@export var inventory_data: InventoryData

@export var is_lockable: bool = false
@export var is_locked: bool = false
@export var locked_dc: int = 0
@export var lock_code: int = 0

signal toggle_inventory(external_inventory_owner)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_area.interact = Callable(self, "onInteract")
	InteractionManager.connect("interaction_area_exited", _on_interaction_area_exited)
	
	if PlayerManager.player:
		var message_label = PlayerManager.player.get_node_or_null("UI/MessageLabel")
		if message_label:
			print("Message Label found: ", message_label)
		else:
			print("Error: MessageLabel not found at Player/UI/MessageLabel")
	else: 
		print("Error: PlayerManager.player is null")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func onInteract():
	if not is_locked:
		notLocked()
	else: 
		var message_label = PlayerManager.player.get_node_or_null("UI/MessageLabel")
		if message_label:
			
			message_label.text = "Container is locked."
			message_label.visible = true
			print("Showing message_label")
			await get_tree().create_timer(2.0).timeout
#			message_label.visible = false
			message_label.text = ""
		else:
			print("Error: cannot show message")

		
func notLocked():
	if self.is_in_group("NonAnimated"):
		PlayerManager.player.emit_signal("toggle_inventory")
		toggle_inventory.emit(self)
	else:
	
		animated_sprite.frame = 0 if animated_sprite.frame == 1 else 1
		if animated_sprite.frame == 1:
			PlayerManager.player.emit_signal("toggle_inventory")
			toggle_inventory.emit(self)
		else:
			
			PlayerManager.player.emit_signal("toggle_inventory")
			toggle_inventory.emit(self)
	pass



func _on_interaction_area_exited(area: InteractionArea):
	if area == interaction_area:
		if self.is_in_group("NonAnimated"):
			if PlayerManager.player.inventory_interface.visible:
				toggle_inventory.emit(self)
				PlayerManager.player.emit_signal("toggle_inventory")
			
		else:
			if animated_sprite.frame == 1:
				animated_sprite.frame = 0
				toggle_inventory.emit(self)
				PlayerManager.player.emit_signal("toggle_inventory")
