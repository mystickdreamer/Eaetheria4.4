extends Control

var grabbed_slot_data: SlotData
var external_inventory_owner

@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var grabbed_slot: PanelContainer = $GrabbedSlot
@onready var external_inventory: PanelContainer = $ExternalInventory
@onready var armor_inventory: PanelContainer = $ArmorInventory
@onready var head_inventory: PanelContainer = $HeadInventory
@onready var feet_inventory: PanelContainer = $FeetInventory
@onready var hand_inventory: PanelContainer = $HandInventory
@onready var amulet_inventory: PanelContainer = $AmuletInventory
@onready var belt_inventory: PanelContainer = $BeltInventory
@onready var ring_inventory: PanelContainer = $RingInventory
@onready var ring_inventory_2: PanelContainer = $RingInventory2
@onready var weapon_inventory: PanelContainer = $WeaponInventory



signal drop_slot_data(slot_data: SlotData)

func _ready() -> void:
	call_deferred("_connect_armor_signals")


func _physics_process(_delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)

func set_player_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	
func set_armor_inventory_data(inventory_data: InventoryDataArmor)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	armor_inventory.set_inventory_data(inventory_data)
func set_head_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	head_inventory.set_inventory_data(inventory_data)
func set_feet_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	feet_inventory.set_inventory_data(inventory_data)
func set_hand_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	hand_inventory.set_inventory_data(inventory_data)
func set_amulet_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	amulet_inventory.set_inventory_data(inventory_data)
func set_belt_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	belt_inventory.set_inventory_data(inventory_data)
func set_ring_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	ring_inventory.set_inventory_data(inventory_data)
func set_ring2_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	ring_inventory_2.set_inventory_data(inventory_data)	
func set_weapon_inventory_data(inventory_data: InventoryData)->void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	weapon_inventory.set_inventory_data(inventory_data)

func set_external_inventory(_external_inventory_owner)->void:
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory.set_inventory_data(inventory_data)
	
	external_inventory.show()
	
func clear_external_inventory()->void:
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory.clear_inventory_data(inventory_data)
		
		external_inventory.hide()
		external_inventory_owner = null

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int)->void:
	
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
	
	update_grabbed_slot()

func update_grabbed_slot()->void:
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and grabbed_slot_data:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				var mouse_position = get_global_mouse_position()
				var rects_to_check = [
				player_inventory, head_inventory, armor_inventory, feet_inventory, 
				hand_inventory, amulet_inventory, ring_inventory, ring_inventory_2, 
				belt_inventory, weapon_inventory, external_inventory
				]
				var is_over_any_slot = false
				@warning_ignore("unused_variable")
				var target_slot = null
				for rect in rects_to_check:
					if rect.get_rect().has_point(mouse_position):
						is_over_any_slot = true
						target_slot = rect
						break
				if not is_over_any_slot:
					#Drop the item
					drop_slot_data.emit(grabbed_slot_data)
					grabbed_slot_data = null
			MOUSE_BUTTON_RIGHT:
				var mouse_position = get_global_mouse_position()
				if not player_inventory.get_rect().has_point(mouse_position):
					drop_slot_data.emit(grabbed_slot_data.create_single_slot_data())
					if grabbed_slot_data.quantity < 1:
						grabbed_slot_data = null
		update_grabbed_slot()


func _on_visibility_changed() -> void:
	if not visible and grabbed_slot_data:
		drop_slot_data.emit(grabbed_slot_data)
		grabbed_slot_data = null
		update_grabbed_slot()

@warning_ignore("unused_parameter")
func _on_armor_action_needed(action: String, slot_data: SlotData, index: int):
	print("Called the on armor action needed function ")
	if action == "removeArmor":
		PlayerManager.player.armor_bonus -= slot_data.item_data.armor_bonus
		PlayerManager.player.evasion_penalty += slot_data.item_data.evade_penalty
		PlayerManager.player.armor_skill = 0
		PlayerManager.player.weapon_stat = 0
	elif action == "removeEquip":
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Weapon:
			PlayerManager.player.weapon_skill = 0
			PlayerManager.player.weapon_damage -= slot_data.item_data.attack_damage
			PlayerManager.player.evasion_penalty += slot_data.item_data.evade_penalty
			PlayerManager.player.weapon_skill_name = ""
			PlayerManager.player.weapon_stat_name = ""
			PlayerManager.player.weapon_stat = 0
			PlayerManager.player.weapon_bow = null
			PlayerManager.player.weapon_ammo = null
			PlayerManager.player.weapon_sprite = null
			PlayerManager.player.is_bow = false
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Head:
			PlayerManager.player.visibility_range -= slot_data.item_data.visibility_range
			PlayerManager.player.intelligence_bonus -= slot_data.item_data.intelligence_bonus
			PlayerManager.player.mana_bonus -= slot_data.item_data.mana_bonus

		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Amulet:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Belt:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Feet:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Hands:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Ring:
			pass
	elif action == "addEquip":
		print("Called on armor action needed add function")
		if slot_data.item_data.Skill_Used != 9:
			match slot_data.item_data.Skill_Used:
				6:
					PlayerManager.player.armor_bonus += slot_data.item_data.armor_bonus
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.armor_skill = PlayerManager.player.lightArmor
					PlayerManager.player.armor_skill_name = "lightArmor"
				7:
					PlayerManager.player.armor_bonus += slot_data.item_data.armor_bonus
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.armor_skill = PlayerManager.player.medArmor
					PlayerManager.player.armor_skill_name = "medArmor"
				8:
					PlayerManager.player.armor_bonus += slot_data.item_data.armor_bonus
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.armor_skill = PlayerManager.player.hevArmor
					PlayerManager.player.armor_skill_name = "hevArmor"
				5:
					#MartialArts
					PlayerManager.player.weapon_skill = PlayerManager.player.martialArts
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					#Martial Arts weapons should never give an evade penalty, but just in case 
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_skill_name = "martialArts"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					pass
				4:
					#Thrown
					PlayerManager.player.weapon_skill = PlayerManager.player.thrown
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_range = slot_data.item_data.weapon_range
					PlayerManager.player.weapon_skill_name = "thrown"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					pass
				3:
					#OneHanded
					PlayerManager.player.weapon_skill = PlayerManager.player.oneHand
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_skill_name = "oneHand"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					pass
				2:
					#GreatWeapon
					PlayerManager.player.weapon_skill = PlayerManager.player.greatWeap
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					#PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_skill_name = "greatWeap"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					pass
				1:
					#TwoWeapon
					PlayerManager.player.weapon_skill = PlayerManager.player.twoWeap
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_skill_name = "twoWeap"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					pass
				0:
					#Archery
					PlayerManager.player.weapon_skill = PlayerManager.player.archery
					PlayerManager.player.weapon_damage += slot_data.item_data.attack_damage
					PlayerManager.player.evasion_penalty -= slot_data.item_data.evade_penalty
					PlayerManager.player.weapon_sprite = slot_data.item_data.texture
					PlayerManager.player.weapon_range = slot_data.item_data.weapon_range
					PlayerManager.player.weapon_bow = slot_data.item_data.texture
					PlayerManager.player.weapon_ammo = slot_data.item_data.ammo_texture
					PlayerManager.player.is_bow = true
					PlayerManager.player.weapon_skill_name = "archery"
					if slot_data.item_data.companion_skill == itemData.companionSkill.Agility:
						PlayerManager.player.weapon_stat = PlayerManager.player.agility
						PlayerManager.player.weapon_stat_name = "agility"
					else:
						PlayerManager.player.weapon_stat = PlayerManager.player.might
						PlayerManager.player.weapon_stat_name = "might"
					
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Head:
			PlayerManager.player.visibility_range += slot_data.item_data.visibility_range
			PlayerManager.player.intelligence_bonus += slot_data.item_data.intelligence_bonus
			PlayerManager.player.mana_bonus += slot_data.item_data.mana_bonus
			
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Amulet:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Belt:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Feet:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Hands:
			pass
		if slot_data.item_data.itemSlottype == itemData.itemSlotType.Ring:
			pass
			
				
func _connect_armor_signals():
	var armor_inventory_data = armor_inventory.get_inventory_data()
	if armor_inventory_data:
		armor_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var weapon_inventory_data = weapon_inventory.get_inventory_data()
	if weapon_inventory_data:
		weapon_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var head_inventory_data = head_inventory.get_inventory_data()
	if head_inventory_data:
		head_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var feet_inventory_data = feet_inventory.get_inventory_data()
	if feet_inventory_data:
		feet_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var hand_inventory_data = hand_inventory.get_inventory_data()
	if hand_inventory_data:
		hand_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var amulet_inventory_data = amulet_inventory.get_inventory_data()
	if amulet_inventory_data:
		amulet_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var belt_inventory_data = belt_inventory.get_inventory_data()
	if belt_inventory_data:
		belt_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var ring_inventory_data = ring_inventory.get_inventory_data()
	if ring_inventory_data:
		ring_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
	var ring2_inventory_data = ring_inventory_2.get_inventory_data()
	if ring2_inventory_data:
		ring2_inventory_data.armor_action_needed.connect(_on_armor_action_needed)
