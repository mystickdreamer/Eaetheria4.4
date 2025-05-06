extends Resource
class_name craftingRecipeRequirement

@export var item: itemData
@export var quantity: int

@export_category("Skills")
enum skillUsed {None, Cooking, Blacksmithing, Weaponsmithing, Armorsmithing, Enchanting, Alchemy, Leatherworking, Woodworking, Thievery}
@export var skillToUse: skillUsed = skillUsed.None
@export var successesNeeded: int = 0
