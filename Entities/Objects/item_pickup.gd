extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: Sprite2D = $Sprite2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var quantity_label: Label = $QuantityLabel

@export var slot_data: SlotData

func _ready() -> void:
	interaction_area.interact = Callable(self, "onInteract")
	sprite.texture = slot_data.item_data.texture
	print(sprite.texture)
	quantity_label.text = "%s" % slot_data.quantity
	print(slot_data.quantity)
	
	
func onInteract()->void:
	if PlayerManager.player.inventory_data.pick_up_slot_data(slot_data):
		queue_free()
	print("Picked up")
	pass

func set_item_data(data: SlotData):
	slot_data = data
#	update_item_display()
	
func update_item_display():
	if slot_data:
		sprite.texture = slot_data.item_data.texture
		quantity_label.text = str(slot_data.quantity)
	else:
		print("Error: no slot_data provided")
