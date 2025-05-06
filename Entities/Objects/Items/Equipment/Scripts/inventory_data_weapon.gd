extends InventoryData
class_name InventoryDataWeapon

signal armor_action_needed(action: String, slot_data: SlotData, index: int)

var inventory_data: InventoryData


func get_inventory_data()->InventoryData:
	return inventory_data

func drop_slot_data(grabbed_slot_data: SlotData, index: int)->SlotData:
	if not grabbed_slot_data.item_data.itemSlottype == itemData.itemSlotType.Weapon:
		print("This equipment is not armor")
		return grabbed_slot_data
	elif grabbed_slot_data.item_data.item_size != PlayerManager.player.race.size_category:
		print("Size category different")
		return grabbed_slot_data
	var slot_data = grabbed_slot_data
	print(grabbed_slot_data.item_data.Skill_Used)
	armor_action_needed.emit("removeEquip", slot_data, index)
	armor_action_needed.emit("addEquip", slot_data, index)
	return super.drop_slot_data(grabbed_slot_data, index)
	
func drop_single_slot_data(grabbed_slot_data: SlotData, index: int)->SlotData:
	if not grabbed_slot_data.item_data.itemSlottype == itemData.itemSlotType.Weapon:
		print("This equipment is not a weapon")
		return grabbed_slot_data
	elif grabbed_slot_data.item_data.item_size != PlayerManager.player.race.size_category:
		print("Size category different")
		return grabbed_slot_data
	var slot_data = grabbed_slot_data
	print(grabbed_slot_data.item_data.Skill_Used)
	armor_action_needed.emit("addEquip", slot_data, index)
	return super.drop_single_slot_data(grabbed_slot_data, index)

func grab_slot_data(index: int)->SlotData:
	var slot_data = slot_datas[index]
	
	if slot_data and slot_data.item_data.itemSlottype == itemData.itemSlotType.Weapon:
		armor_action_needed.emit("removeEquip", slot_data, index)
	var grabbed = super.grab_slot_data(index)
	return grabbed
