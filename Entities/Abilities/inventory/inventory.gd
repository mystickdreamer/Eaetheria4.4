extends PanelContainer
class_name Inventory

const Slot = preload("res://Entities/Abilities/inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ScrollContainer/ItemGrid

var inventory_data: InventoryData
var current_inventory_data: InventoryData

enum itemSlotType {Head, Armor, Hands, Feet, Amulet,Ring, Belt, Weapon, Inv }
@export var itemSlottype: itemSlotType = itemSlotType.Inv

func set_inventory_data(inventory_data: InventoryData)->void:
	current_inventory_data = inventory_data
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)
	
func get_inventory_data()->InventoryData:
	return current_inventory_data
	
func clear_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_updated.disconnect(populate_item_grid)
	
func populate_item_grid(inventory_data: InventoryData)->void:
	
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
			
func addSlot(inventory_data: InventoryData, slot_data: SlotData = null)->void:
	inventory_data.addSlot(slot_data)
