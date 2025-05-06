extends CharacterBody2D
class_name Entity

@export var speed: float = 100.00
var accel: float = 10.0
var minSpeed: float = 10.0
var maxSpeed: float = 150.0

var isMoving: bool = false
var input: Vector2
var sneaking: bool = false
var sneakRoll: int = 0

var armor_bonus: int = 0
var armor_skill: int = 0
var evasion_penalty: int = 0

@export var char_name: String = ""
@export var race: Race = preload("res://Entities/Resources/Races/None.tres")
enum Sex {
	NONE = 0,
	Male = 1,
	Female = 2
}
#Male = 1, Female = 2
@export var sex: Sex = Sex.NONE

static var Vision = {
	Normal = 0,
	LowLight = 1,
	DarkVis = 2
}
@export var vision: int = Vision.Normal

#Stat scores
@export_category("Stats")
@export var might : int = 1
var might_xp: float = 0.00
@export var agility: int = 1
var agility_xp: float = 0.00
@export var endurance: int = 1
var endurance_xp: float = 0.00

@export var intelligence: int = 1
var intelligence_xp: float = 0.00
@export var cunning: int = 1
var cunning_xp: float = 0.00
@export var willpower: int = 1
var willpower_xp: float = 0.00

@export var charisma: int = 1
var charisma_xp: float = 0.00
@export var influence: int = 1
var influence_xp: float = 0.00
@export var appearance: int = 1
var appearance_xp: float = 0.00

@export var hp: float = 5.0
@export var max_hp: float = 5.0
var max_hp_xp: float = 0.00
var healthRegen: float = 0.0015
@export var mana : float = 1.0
@export var max_mana : float = 1.0
var max_mana_xp: float = 0.00
var manaRegen: float = 0.0015
@export var stamina : int = 1
@export var max_stamina: int = 1
var max_stamina_xp: float = 0.00

@export var currentWeight: int = 0
@export var maxWeight: int = 50


var multip = 8

@export_category("Combat Skills")
#Combat Skills
@export var archery: int = 0
var archery_xp: float = 0.00
@export var twoWeap: int = 0
var twoWeap_xp: float = 0.00
@export var greatWeap: int = 0
var greatWeap_xp: float = 0.00
@export var oneHand: int = 0
var oneHand_xp: float = 0.00
@export var thrown: int = 0
var thrown_xp: float = 0.00
@export var martialArts: int = 0
var martialArts_xp: float = 0.00
#Armor Skills
@export var lightArmor: int = 0
var lightArmor_xp: float = 0.00
@export var medArmor: int = 0
var medArmor_xp: float = 0.00
@export var hevArmor: int = 0
var hevArmor_xp: float = 0.00

@export var evasion: int 
var evasion_xp: float = 0.00

@export_category("Magick Skills")
#Verbiage 
@export var creo: int = 0
var creo_xp: float = 0.00
@export var intelligo: int = 0
var intelligo_xp: float = 0.00
@export var muto: int = 0
var muto_xp: float = 0.00
@export var perdo: int =0
var perdo_xp: float = 0.00
@export var rego: int = 0
var rego_xp: float = 0.00

#Nounage
@export var animal: int = 0
var animal_xp: float = 0.00
@export var aquam: int = 0
var aquam_xp: float = 0.00
@export var auram: int = 0
var auram_xp: float = 0.00
@export var corpus: int = 0
var corpus_xp: float = 0.00
@export var herbam: int = 0
var herbam_xp: float = 0.00
@export var ignem: int = 0
var ignem_xp: float = 0.00
@export var imaginem: int = 0
var imaginem_xp: float = 0.00
@export var mentem: int = 0
var mentem_xp: float = 0.00
@export var terram: int = 0
var terram_xp: float = 0.00
@export var magicka: int = 0
var magicka_xp: float = 0.00

@export_category("Survival Skills")
#Survival Skills
@export var athletics: int = 0
var athletics_xp: float = 0.00
@export var deception: int = 0
var deception_xp: float = 0.00
@export var history: int = 0
var history_xp: float = 0.00
@export var insight: int = 0
var insight_xp: float = 0.00
@export var intimidation: int = 0
var intimidation_xp: float = 0.00
@export var investigation: int = 0
var investigation_xp: float = 0.00
@export var knowledge: int = 0
var knowledge_xp: float = 0.00
@export var firstaid: int = 0
var firstaid_xp: float = 0.00
@export var nature: int = 0
var nature_xp: float = 0.00
@export var perception: int = 0
var perception_xp: float = 0.00
@export var performance: int = 0
var performance_xp: float = 0.00
@export var religion: int = 0
var religion_xp: float = 0.00
@export var ride: int = 0
var ride_xp: float = 0.00
@export var stealth: int = 0
var stealth_xp: float = 0.00
@export var survival: int = 0
var survival_xp: float = 0.00
@export var thievery: int = 0
var thievery_xp: float = 0.00

@export_category("Crafting Skills")
@export var mining: int = 0
var mining_xp: float = 0.00
@export var logging: int = 0
var logging_xp: float = 0.00
@export var cooking: int = 0
var cooking_xp: float = 0.00
@export var fishing: int = 0
var fishing_xp: float = 0.00
@export var blacksmithing: int = 0
var blacksmithing_xp: float = 0.00
@export var weaponsmithing: int = 0
var weaponsmithing_xp: float = 0.00
@export var armorsmithing: int = 0
var armorsmithing_xp: float = 0.00
@export var enchanting: int = 0
var enchanting_xp: float = 0.00
@export var alchemy: int = 0
var alchemy_xp: float = 0.00
@export var leatherworking: int = 0
var leatherworking_xp: float = 0.00
@export var woodworking: int = 0
var woodworking_xp: float = 0.00

var moveDirection: Vector2 = Vector2.ZERO

@export var coins: int = 0

#Monster only area start
@export var monster_difficulty: int = 1
#Monster only area end

#var global_cooldown = 100   @Outdated no longer use may delete later idk
var isBusy: bool = false
var lastAbility: int = 0

@export var xpPool: int = 375

var weapon_skill_name: String = ""
var weapon_sprite: AtlasTexture = null
var weapon_bow: AtlasTexture = null
var weapon_ammo: AtlasTexture = null
var is_bow: bool = false
var weapon_skill: int = 0
var weapon_damage_bonus: int = 0
var weapon_damage: int = 0
var weapon_stat_name: String = ""
var weapon_stat:int = 0
var weapon_range: int = 0

var attack_skill:int = 0
var attack_skill2:int = 0
var attack_stat:int = 0

var toolHeld: String = ""

var detectMagic: bool = false
var detectMagicTimer: int = 0

@export var visibility_range: int = 1
var intelligence_bonus: int = 0
var mana_bonus: int = 0

#Equipment bonuses
var evasion_bonus:int = 0
var armor_extra_bonus: int = 0


#status effects
var is_wet: bool = false
var wet_timer: float = 0.0

var is_burning: bool = false
var burning_timer: float = 0.0

var is_chilled: bool = false
var chilled_timer: float = 0.0

var is_webbed: bool = false
var webbed_timer: float = 0.0

var is_frozen: bool = false
var frozen_timer: float = 0.0

var is_poisoned: bool = false
var poison_damage: int = 0
var poisoned_timer: float = 0.0

var is_stunned: bool = false
var stunned_timer: float = 0.0

var is_flying: bool = false
var flying_timer: float = 0.0

var is_jumping: bool = false
var jumping_timer: float = 0.0

var is_cursed: bool = false
var cursed_timer: float = 0.0

var is_blessed: bool = false
var blessed_timer: float = 0.0

var is_blind: bool = false
var blind_timer: float = 0.0

var is_fear: bool = false
var fear_timer: float = 0.0

var is_rage: bool = false
var rage_timer: float = 0.0

var is_invisible: bool = false
var invisible_timer: float = 0.0

var is_slow: bool = false
var slow_timer: float = 0.0

func _init() -> void:
	if race == null:
		race = preload("res://Entities/Resources/Races/human.tres")
	xpPool += race.start_xp_bonus

func regenHealth():
	if (hp < max_hp):
		if ((healthRegen + hp) > max_hp):
			hp = max_hp
		else: hp += healthRegen
		
func regenMana():
	if (mana < max_mana):
		if ((manaRegen + mana) > max_mana):
			mana = max_mana
		else: mana += manaRegen
		
func modifyMana(amount):
	var newMana = mana + amount
	if (newMana < 0): mana = 0
	else:
		mana = newMana
		
func modifyHealth(amount):
	var newhp = hp + amount
	if (newhp < 0): hp = 0
	else:
		hp = newhp

#Adding this here not sure if going to use it yet 
func apply_damage(amount):
	#This would be where roll for armor would come into it
	if (hp > amount): hp -= amount
	else: print("Ya dead")
	
func _physics_process(delta: float) -> void:
	if wet_timer > 0:
		wet_timer -= delta
	else:
		is_wet = false
	if webbed_timer > 0:
		webbed_timer -= delta
	else:
		is_webbed = false
	if burning_timer > 0:
		burning_timer -= delta
	else:
		is_burning = false
	if chilled_timer > 0:
		chilled_timer -= delta
	else:
		is_chilled = false
	if frozen_timer > 0:
		frozen_timer -= delta
	else:
		is_frozen = false
	if poisoned_timer > 0:
		poisoned_timer -= delta
	else:
		is_poisoned = false	
	if stunned_timer > 0:
		stunned_timer -= delta
	else:
		is_stunned = false
	if flying_timer == -1:
		return
	if flying_timer > 0:
		flying_timer -= delta
	else:
		is_flying = false
	if cursed_timer > 0:
		cursed_timer -= delta
	else:
		is_cursed = false	
	if blessed_timer > 0:
		blessed_timer -= delta
	else:
		is_blessed = false
	if blind_timer > 0:
		blind_timer -= delta
	else:
		is_blind = false
	if fear_timer > 0:
		fear_timer -= delta
	else:
		is_fear = false
	if rage_timer > 0:
		rage_timer -= delta
	else:
		is_rage = false
	if chilled_timer > 0:
		chilled_timer -= delta
	else:
		is_chilled = false
	if invisible_timer > 0:
		invisible_timer -= delta
	else:
		is_invisible = false
	if slow_timer > 0:
		slow_timer -= delta
	else:
		is_slow = false
		
	if lastAbility > 0:
		lastAbility -= delta


	
	
func loadAbility(name: String):
	var scene = load("res://Entities/Abilities/" + name + "/" + name + ".tscn")
	var sceneNode = scene.instantiate()
	add_child(sceneNode)
	return sceneNode
	
	
func required_xp(stat_name : String, stat_value: int, multi: int) -> int:
	var multiplier = multi #default multiplier
	
	if race:
		match stat_name:
			"might":
				multiplier += 2
				multiplier += race.might_multiplier
			"agility":
				multiplier += 2
				multiplier += race.agility_multiplier
			"endurance":
				multiplier += 2
				multiplier += race.endurance_multiplier
			"intelligence":
				multiplier += 2
				multiplier += race.intelligence_multiplier
			"cunning":
				multiplier += 2
				multiplier += race.cunning_multiplier
			"willpower":
				multiplier += 2
				multiplier += race.willpower_multiplier
			"charisma":
				multiplier += 2
				multiplier += race.charisma_multiplier
			"influence":
				multiplier += 2
				multiplier += race.influence_multiplier
			"appearance":
				multiplier += 2
				multiplier += race.appearance_multiplier
	var XpNeeded = (stat_value + 1) * multiplier
	print("Multiplier: ", multiplier)
	return XpNeeded

func increase_stat(name: String) -> bool:
	var current_value = PlayerManager.player.get(name)
	return attempt_increase(name, current_value, multip)
	

	
func attempt_increase(name: String, value: int, multi: int) -> bool:
	print("Got to attempt_increase")
	var req_xp = required_xp(name, value, multi)
	var xp_variable = name + "_xp"
	
	if PlayerManager.player[xp_variable] >= 0:
		print("Passed the if check in attempt_increase")
		var current_xp = PlayerManager.player[xp_variable]
		if current_xp >= req_xp:
			print("passed if check, checking currentxp vs reqxp")
			PlayerManager.player[xp_variable] -= req_xp
			print("Required XP: ", req_xp)
			PlayerManager.player[name] += 1
			
			if name == "might":
				calculateAndSetSlotSize()
				calculate_stamina()
			elif name == "intelligence" or name == "willpower":
				calculate_mana()
			elif name == "endurance":
				calculate_stamina()
			
			return true
		else:
			print("Not enough XP to increase ", name)
			return false
	else:
		print(" Error: XP variable '%s' does not exist for skill '%s'." % [xp_variable, name])
		return false

var skill_nameXP: String = ""
var skill_success_xp: float = 0.0

func add_xp()->void:
	var xp_variable = skill_nameXP + "_xp"
	print(xp_variable)
	var amount = skill_success_xp
	if PlayerManager.player.skill_nameXP == "":
		return
	if PlayerManager.player[skill_nameXP]:
		PlayerManager.player[xp_variable] += amount
		var rank_amount = PlayerManager.player[skill_nameXP]
		if attempt_increase(skill_nameXP, rank_amount, multip):
			print("%s increased!" % name)
			print("Rank is: ", PlayerManager.player[name])
			skill_nameXP = ""
		skill_nameXP = ""
	else:
		print("There was a call to a skill name that does not exist")

var skill1: String = ""
var skill2: String = ""
var skill_stat: String = ""
func add_xp_skill()->void:
	if skill1 != "":
		skill_nameXP = skill1
		add_xp()
		skill1 = ""
	if skill_stat != "":
		skill_nameXP = skill_stat
		add_xp()
		skill_stat = ""
	if skill2 != "":
		skill_nameXP = skill2
		add_xp()
		skill2 = ""
	skill_success_xp = 0
	pass
	
var stats_printed = false
#Debugging to print player stats
func print_stats()->void:
	if not stats_printed:
		var debug_label = get_node("DebugLabel")
		print("Player Stats:")
		if debug_label:
			debug_label.text += "Player Stats:"
			debug_label.text += "\nskill1: " + str(skill1)
			debug_label.text += "\nskillstat: " + str(skill_stat)
			debug_label.text += "\n1hand: " + str(oneHand)
			debug_label.text += "\n1handXP: " + str(oneHand_xp)
			debug_label.text += "\nwepDamTest: " + str(attack_skill2)
		print("Visibility Range: ", visibility_range)
		print("Intelligence bonus: ", intelligence_bonus)
		print("Mana Bonus: ", mana_bonus)
		print("lastAbility: ", lastAbility)
		print("rego rank: ", rego)
		print("rego xp ", rego_xp)
		print("corpus rank: ", corpus)
		print("corpus xp ", corpus_xp)
		print("1Handxp: ",oneHand_xp)
		print("agility xp: ", agility_xp)
		print(weapon_skill_name)
		print(skill_nameXP)
		print(skill_success_xp)
		print("agility: ", agility)
		print("weapon_stat_name: ", weapon_stat_name)
		print("Weapon stat: ", weapon_stat)
		stats_printed = true
	
		


func calculateAndSetSlotSize():
	var new_size = max(0, (PlayerManager.player.might*10)+5)
	PlayerManager.player.inventory_data.slot_datas.resize(new_size)
	print("new size is ", PlayerManager.player.inventory_data.slot_datas.size())
	pass
	
func calculate_mana():
	PlayerManager.player.max_mana = PlayerManager.player.intelligence + PlayerManager.player.willpower
	PlayerManager.player.mana = PlayerManager.player.max_mana
	
func calculate_stamina():
	PlayerManager.player.max_stamina = PlayerManager.player.endurance + PlayerManager.player.might
	PlayerManager.player.stamina = PlayerManager.player.max_stamina
	
#This is a rework of how this is called, not tested yet looks solid though 
func evasionRoll(evas: int, agil: int, evas_penalty: int, evas_bonus: int)->int:
	if is_stunned or is_frozen:
		return 0
	var evasionDice = agil + evas - evas_penalty
	if is_webbed or is_blind:
		evasionDice -= 2
	var evasionResults = globalDiceRoller.roll_dice(evasionDice, evas_bonus)
	return evasionResults

func get_armor_defense(armorSk: int, armorBon: int, endur: int, armorEB)->int:
	var defense_dice = armorBon + armorSk + endur
	var armorRoll = globalDiceRoller.roll_dice(defense_dice, armorEB)
	return armorRoll
	pass
