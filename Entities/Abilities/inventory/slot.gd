extends PanelContainer

signal slot_clicked(index: int, button: int)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel
@onready var uses_label: Label = $UsesLabel

#enum itemSlotType {Head, Armor, Hands, Feet, Amulet,Ring, Belt, Weapon, Inv }
#@export var itemSlottype: itemSlotType = itemSlotType.Inv

func set_slot_data(slot_data: SlotData) ->void:
	var item_data = slot_data.item_data
	texture_rect.texture = item_data.texture
	if item_data.uses <= 1:
		tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	else:
		tooltip_text = "%s\n%s\nUses: %s" % [item_data.name, item_data.description, item_data.uses]
	
	
	if slot_data.quantity > 1:
		quantity_label.text = "%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()
		
	if slot_data.item_data.uses > 1:
		uses_label.text = "%s" % slot_data.item_data.uses
		uses_label.show()
	else:
		uses_label.hide()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
			
