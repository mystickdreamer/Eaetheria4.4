extends Resource
class_name spellRecipeRequirement

@export var item: itemData
@export var quantity: int

@export_category("Skills")
enum skillUsed {None, Cooking, Blacksmithing, Weaponsmithing, Armorsmithing, Enchanting, Alchemy, Leatherworking, Thievery}
@export var skillToUse: skillUsed = skillUsed.None
@export var successesNeeded: int = 0
