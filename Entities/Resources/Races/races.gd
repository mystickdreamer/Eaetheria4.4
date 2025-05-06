extends Resource

class_name Race


@export_category("Stat Bonuses")
@export var might_multiplier: int = 0
@export var agility_multiplier: int = 0
@export var endurance_multiplier: int = 0

@export var intelligence_multiplier: int = 0
@export var cunning_multiplier: int = 0
@export var willpower_multiplier: int = 0

@export var charisma_multiplier: int = 0
@export var influence_multiplier: int = 0
@export var appearance_multiplier: int = 0


@export_category("Other Bonuses")
@export var start_xp_bonus: int = 0
@export var speed_bonus: float = 0.0
@export var vision_bonus: int = 0

@export var health_bonus: int = 0

#Size category of race 1 - 7
@export var size_category: int = 4


#generic race shouldn't ever see this 
@export var race_name: String = "Human"
@export var description: String = " A versatile and balanced race"
