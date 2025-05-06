extends Resource
class_name InventoryData

signal inventory_updated(Inventory_data: InventoryData)

signal inventory_interact(inventory_data: InventoryData, index: int, button: int)



@export var slot_datas: Array[SlotData]

func on_slot_clicked(index: int, button: int)->void:
	inventory_interact.emit(self, index, button)
	
func grab_slot_data(index: int)->SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data:
#		if get_parent().slot_data.item_data.itemSlottype == itemData.itemSlotType.Armor:
#			print("This ")
		slot_datas[index] = null
		inventory_updated.emit(self)
		return slot_data
	else: 
		return null
		
func drop_slot_data(grabbed_slot_data: SlotData, index: int)->SlotData:
	var slot_data = slot_datas[index]
	
	var return_slot_data: SlotData
	if slot_data and slot_data.can_fully_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data)
	else:
		slot_datas[index] = grabbed_slot_data
		return_slot_data = slot_data
		
	inventory_updated.emit(self)
	return return_slot_data

func drop_single_slot_data(grabbed_slot_data: SlotData, index: int)->SlotData:
	var slot_data = slot_datas[index]
	
	if not slot_data:
		slot_datas[index] = grabbed_slot_data.create_single_slot_data()
	elif slot_data.can_merge_with(grabbed_slot_data):
		slot_data.fully_merge_with(grabbed_slot_data.create_single_slot_data())
		
	inventory_updated.emit(self)
	
	if grabbed_slot_data.quantity > 0:
		return grabbed_slot_data
	else:
		return null
		
func pick_up_slot_data(slot_data: SlotData)->bool:
	for index in slot_datas.size():
		if slot_datas[index] and slot_datas[index].can_fully_merge_with(slot_data):
			slot_datas[index].fully_merge_with(slot_data)
			inventory_updated.emit(self)
			return true
	for index in slot_datas.size():
		if not slot_datas[index]:
			slot_datas[index] = slot_data
			inventory_updated.emit(self)
			return true
		
	return false
	
func addSlot(slot_data: SlotData = null)->void:
	slot_datas.append(slot_data)
	inventory_updated.emit()

func use_slot_data(index)->void:
	var slot_data = slot_datas[index]
	if not slot_data:
		return
	if slot_data.item_data.type == itemData.itemType.Consumable:
		var item = slot_data.item_data
		var was_used = item.use()
		
		if was_used == false:
			return
		else:
			if item.uses == -1:
				return
			if item.uses > 1:
				item.uses -= 1
			else:
				slot_data.quantity -= 1
				item.uses = slot_datas[index].item_data.max_uses
				if slot_data.quantity < 1:
					slot_datas[index] = null 
	print(slot_data.item_data.name)
	inventory_updated.emit(self)
	
	pass
