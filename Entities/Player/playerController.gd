extends Entity
class_name Player

@export var inventory_data: InventoryData
@export var armor_inventory: InventoryDataArmor
@export var head_inventory: InventoryDataHead
@export var feet_inventory: InventoryDataFeet
@export var hand_inventory: InventoryDataHand
@export var amulet_inventory: InventoryDataAmulet
@export var belt_inventory: InventoryDataBelt
@export var ring_inventory: InventoryDataRing
@export var ring2_inventory: InventoryDataRing
@export var weapon_inventory: InventoryDataWeapon
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hotbar_inventory: PanelContainer = $UI/HotbarInventory

@onready var message_label: Label = $UI/MessageLabel




@onready var debug_label: Label = $DebugLabel



signal toggleInventory()

const PICKUP =  preload("res://Entities/Objects/item_pickup.tscn")

# ====== ABILITIES =======
var abilities = {
	"blink": true,
	"sneak": true,
	"attack": true,
	"pick": true
}

func _ready() -> void:
	PlayerManager.player = self
	inventory_interface.set_player_inventory_data(self.inventory_data)
	inventory_interface.set_armor_inventory_data(self.armor_inventory)
	inventory_interface.set_head_inventory_data(self.head_inventory)
	inventory_interface.set_feet_inventory_data(self.feet_inventory)
	inventory_interface.set_hand_inventory_data(self.hand_inventory)
	inventory_interface.set_amulet_inventory_data(self.amulet_inventory)
	inventory_interface.set_ring_inventory_data(self.ring_inventory)
	inventory_interface.set_ring2_inventory_data(self.ring2_inventory)
	inventory_interface.set_belt_inventory_data(self.belt_inventory)
	inventory_interface.set_weapon_inventory_data(self.weapon_inventory)
	hotbar_inventory.set_inventory_data(self.inventory_data)
	self.toggleInventory.connect(toggleInventoryInterface)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggleInventoryInterface)
#	$TakeDamage.player_damaged.connect(take_damage)


	pass
#Moving and facing with keys and mouse
func readInput()->Vector2:
	return Input.get_vector("left", "right", "up", "down").normalized()
func _physics_process(_delta: float) -> void:
	actionInput()
	input = readInput()
	var newVelocity = input * speed
	velocity = velocity.lerp(newVelocity, 0.1)
	if sneaking:
		velocity = velocity/2
	if is_webbed:
		velocity = velocity*0
	move_and_slide()
	isMoving = input.length()>0.1
	updateSpriteBasedOnMouse()
	regenHealth()
	regenMana()
	super._physics_process(_delta)



	
func actionInput():
	if lastAbility == 0:
		if Input.is_action_pressed("attack"):
			useAbility("attack")
			lastAbility = 20
#		if Input.is_action_pressed("interact"):
#			interact()
#			lastAbility = 3
		if Input.is_action_pressed("sneak"):
			useAbility("sneak")
			lastAbility = 3
#		if Input.is_action_pressed("test"):
#			wet_timer = 10
#			is_wet = true
			#learnAbility("blink")
			#print("Blink loaded")
#		if Input.is_action_pressed("test2"):
#			useAbility("blink")
#			lastAbility = 0
	if Input.is_action_pressed("testStats"):
		stats_printed = false
		print_stats()
	pass
	
	#####Leaving this in for now just in case, but it looks like I don't need it
#func interact():
#	var c = getCollisions()
#	if c:
#		if c.get_groups()[0] == "interactable": c.interact()

#func getCollisions():
#	var c = get_last_slide_collision()
#	if ( c && c.get_collider()): return c.get_collider()
#	debug_label.text += "\nCollider:" + str(c.get_collider())

#####################################################################
	
func updateSpriteBasedOnMouse():
	var mousePosition = get_global_mouse_position()
	var direction = (mousePosition - global_position).normalized()
	#update sprite based on movement and direction
	changeSprite(direction)
	pass	
func changeSprite(direction: Vector2)->void:
	var raceAnim = PlayerManager.player.race.race_name
	var facingDirection = ""
	if abs(direction.x) > abs(direction.y):
		facingDirection = "Right" if direction.x > 0 else "Left"
	else:
		facingDirection = "Down" if direction.y > 0 else "Up"
			
	if isMoving:
		var walkAnimation = raceAnim+"_walk_"+facingDirection
#		if animation_player.animation != walkAnimation:
		animation_player.play(walkAnimation)
	else:
		var idleAnimation = raceAnim+"_idle_"+facingDirection
		
#		if animation_player.animation != idleAnimation:
		animation_player.play(idleAnimation)
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		handleMouse(event)
		
	if Input.is_action_just_pressed("inventory"):
		toggleInventory.emit()
	
func handleMouse(_event: InputEventMouseMotion)->void:
	updateSpriteBasedOnMouse()
#End of move and facing

func learnAbility(name: String):
	if name in abilities:
		print("Ability ", name, "is already learned.")
		return
	abilities[name] = true
		
func useAbility(name: String):
	if name in abilities:
		if abilities[name]:
			var ability = loadAbility(name)
			if ability != null and ability.has_method("execute"):
				# Check if the ability node has the execute method
				ability.execute(self)
			else:
				print("Ability ", name, " does not have an 'execute' method.")
		else:
			print("Ability ", name, " is null.")
			
			
	#Inventory functions
func toggleInventoryInterface(external_inventory_owner = null)->void:
	inventory_interface.visible = not inventory_interface.visible

	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()
func _on_inventory_interface_drop_slot_data(slot_data: SlotData) -> void:
	var pickup = PICKUP.instantiate()
	pickup.slot_data = slot_data
	pickup.position = get_global_mouse_position()
	get_parent().add_child(pickup)
