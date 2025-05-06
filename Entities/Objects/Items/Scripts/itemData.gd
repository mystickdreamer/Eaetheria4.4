extends Resource
class_name itemData

enum itemSlotType {Head, Armor, Hands, Feet, Amulet,Ring, Belt, Weapon, Inv }

var scene_path: String = "res://Items/Item Pickup/item_pickup.tscn"

enum itemType {Consumable, Material, Sellable}
@export_category("All Items")
@export var itemSlottype: itemSlotType = itemSlotType.Inv
@export var type: itemType = itemType.Sellable
@export var stackable: bool = false
@export var name : String = "Unknown Item"
@export_multiline var description : String = "There is nothing special about this item."
@export var texture : AtlasTexture
@export var ammo_texture: AtlasTexture
@export var weight: float = 1
@export var item_cost: int = 0


@export_category("Stats and Gameplay")
@export var attack_damage: int = 0
@export var armor_bonus: int = 0
@export var evade_penalty: int = 0
@export var weapon_range: int = 0
enum itemSkillUsed {Archery, TwoWeapon, GreatWeap, OneHand, Thrown, MartialArts, lightarmor, medarmor, hevarmor, None  }
@export var Skill_Used: itemSkillUsed = itemSkillUsed.None
enum companionSkill {Might, Agility}
@export var companion_skill: companionSkill = companionSkill.Agility
@export var visibility_range: int = 0
@export var intelligence_bonus: int = 0
@export var mana_bonus: int = 0

@export_category("Requirements")

@export var req_str: int = 0
@export var req_int: int = 0

@export_category("Item Use Effects")
@export var effects : Array[ItemEffect]

@export_category("Magickal Effects")
@export var magical: bool = false
@export var health_restore: int = 0
@export var mana_restore: int = 0
@export var enchant_mana: int = 0
@export var enchant_level: int = 0
#@export var enchantments: Array[ItemEffect] = []

@export_category("Quest Item?")
@export var is_quest_item: bool = false
@export var quest_id: String = "None"




@export_category("Potential Future Use")
@export var durability: int = 100
@export var max_durability: int = 100
@export var uses: int = 1
@export var max_uses: int = 1
@export var triggers_event: bool = false
@export var event_id: String = "NONE"
@export var upgrade_level: int = 0
@export var max_upgrade_level: int = 0

#Sized category of weapon
@export var item_size: int = 4

@export var item_stolen: bool = false

func use()->bool:
	if effects.size() == 0:
		return false
	
	for e in effects:
		if e:
			e.use()
	return true
