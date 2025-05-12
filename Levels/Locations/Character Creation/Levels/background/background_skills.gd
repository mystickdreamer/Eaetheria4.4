extends Node2D
class_name LearnArcherSkills


@export var signal_name: String = ""

var npc_info: NPCResource
var npc: String = ""

func _ready() -> void:
	if signal_name != "":
		if get_parent().has_signal(signal_name):
			get_parent().connect(signal_name, check_npc_data)
	
	pass
	
	
func check_npc_data()->void:
	if npc_info == null:
		var p = self
		var _checking: bool = true
		while _checking == true:
			p = p.get_parent()
			if p:
				if p is NPC and p.npc_resource:
					npc_info = p.npc_resource
					npc = npc_info.npc_class
					_checking = false
			else:
				_checking = false
				
	reset_skills()
	pass

func reset_skills()->void:
	#resetting stats/skills to default so they can't game the system 
	PlayerManager.player.might = 1
	PlayerManager.player.might_xp = 0.0
	PlayerManager.player.agility = 1
	PlayerManager.player.agility_xp = 0.0
	PlayerManager.player.endurance = 1
	PlayerManager.player.endurance_xp = 0.0
	PlayerManager.player.intelligence = 1
	PlayerManager.player.intelligence_xp = 0.0
	PlayerManager.player.cunning = 1
	PlayerManager.player.cunning_xp = 0.0
	PlayerManager.player.willpower = 1
	PlayerManager.player.willpower_xp = 0.0
	PlayerManager.player.charisma = 1
	PlayerManager.player.charisma_xp = 0.0
	PlayerManager.player.influence = 1
	PlayerManager.player.influence_xp = 0.0
	PlayerManager.player.appearance = 1
	PlayerManager.player.appearance_xp = 0.0
	
	PlayerManager.player.max_hp = 5
	PlayerManager.player.max_hp_xp = 0.0
	PlayerManager.player.max_mana = 5
	PlayerManager.player.max_mana_xp = 0.0
	PlayerManager.player.max_stamina = 5
	PlayerManager.player.max_stamina_xp = 0.0
	
	
	#combat skills
	PlayerManager.player.archery = 0
	PlayerManager.player.archery_xp = 0.0
	PlayerManager.player.twoWeap = 0
	PlayerManager.player.twoWeap_xp = 0.0
	PlayerManager.player.greatWeap = 0
	PlayerManager.player.greatWeap_xp = 0.0
	PlayerManager.player.oneHand = 0
	PlayerManager.player.oneHand_xp = 0.0
	PlayerManager.player.thrown = 0
	PlayerManager.player.thrown_xp = 0.0
	PlayerManager.player.martialArts = 0
	PlayerManager.player.martialArts_xp = 0.0
	PlayerManager.player.lightArmor = 0
	PlayerManager.player.lightArmor_xp = 0.0
	PlayerManager.player.medArmor = 0
	PlayerManager.player.medArmor_xp = 0.0
	PlayerManager.player.hevArmor = 0
	PlayerManager.player.hevArmor_xp = 0.0
	PlayerManager.player.evasion = 0
	PlayerManager.player.evasion_xp = 0.0
	
	
	#Magick Skills
	PlayerManager.player.creo = 0
	PlayerManager.player.creo_xp = 0.0
	PlayerManager.player.intelligo = 0
	PlayerManager.player.intelligo_xp = 0.0
	PlayerManager.player.muto = 0
	PlayerManager.player.muto_xp = 0.0
	PlayerManager.player.perdo = 0
	PlayerManager.player.perdo_xp = 0.0
	PlayerManager.player.rego = 0
	PlayerManager.player.rego_xp = 0.0
	PlayerManager.player.magicka = 0
	PlayerManager.player.magicka_xp = 0.0
	
	PlayerManager.player.animal = false
	PlayerManager.player.aquam = false
	PlayerManager.player.auram = false
	PlayerManager.player.corpus = false
	PlayerManager.player.herbam = false
	PlayerManager.player.ignem = false
	PlayerManager.player.imaginem = false
	PlayerManager.player.mentem = false
	PlayerManager.player.terram = false
	
	#survival skills
	PlayerManager.player.athletics = 0
	PlayerManager.player.athletics_xp = 0.0
	PlayerManager.player.deception = 0
	PlayerManager.player.deception_xp = 0.0
	PlayerManager.player.history = 0
	PlayerManager.player.history_xp = 0.0
	PlayerManager.player.insight = 0
	PlayerManager.player.insight_xp = 0.0
	PlayerManager.player.intimidation = 0
	PlayerManager.player.intimidation_xp = 0.0
	PlayerManager.player.investigation = 0
	PlayerManager.player.investigation_xp = 0.0
	PlayerManager.player.knowledge = 0
	PlayerManager.player.knowledge_xp = 0.0
	PlayerManager.player.firstaid = 0
	PlayerManager.player.firstaid_xp = 0.0
	PlayerManager.player.nature = 0
	PlayerManager.player.nature_xp = 0.0
	PlayerManager.player.perception = 0
	PlayerManager.player.perception_xp = 0.0
	PlayerManager.player.performance = 0
	PlayerManager.player.performance_xp = 0.0
	PlayerManager.player.religion = 0
	PlayerManager.player.religion_xp = 0.0
	PlayerManager.player.ride = 0
	PlayerManager.player.ride_xp = 0.0
	PlayerManager.player.stealth = 0
	PlayerManager.player.stealth_xp = 0.0
	PlayerManager.player.survival = 0
	PlayerManager.player.survival_xp = 0.0
	PlayerManager.player.thievery = 0
	PlayerManager.player.thievery_xp = 0.0
	
	
	#crafting
	PlayerManager.player.mining = 0
	PlayerManager.player.mining_xp = 0.0
	PlayerManager.player.logging = 0
	PlayerManager.player.logging_xp = 0.0
	PlayerManager.player.cooking = 0
	PlayerManager.player.cooking_xp = 0.0
	PlayerManager.player.fishing = 0
	PlayerManager.player.fishing_xp = 0.0
	PlayerManager.player.blacksmithing = 0
	PlayerManager.player.blacksmithing_xp = 0.0
	PlayerManager.player.weaponsmithing = 0
	PlayerManager.player.weaponsmithing_xp = 0.0
	PlayerManager.player.armorsmithing = 0
	PlayerManager.player.armorsmithing_xp = 0.0
	PlayerManager.player.enchanting = 0
	PlayerManager.player.enchanting_xp = 0.0
	PlayerManager.player.alchemy = 0
	PlayerManager.player.alchemy_xp = 0.0
	PlayerManager.player.leatherworking = 0
	PlayerManager.player.leatherworking_xp = 0.0
	PlayerManager.player.woodworking = 0
	PlayerManager.player.woodworking = 0.0
	PlayerManager.player.debug_label.text += str(npc)
	if npc == "archer":
		set_archer_skills()
	elif npc == "fighter":
		set_fighter_skills()
	pass
	
func set_archer_skills()->void:
	PlayerManager.player.might = 1
	PlayerManager.player.agility = 3
	PlayerManager.player.endurance = 1
	PlayerManager.player.intelligence = 2
	PlayerManager.player.cunning = 2
	PlayerManager.player.willpower = 1
	PlayerManager.player.charisma = 1
	PlayerManager.player.influence = 1
	PlayerManager.player.appearance = 1
	
	PlayerManager.player.max_hp = 5
	PlayerManager.player.max_mana = 5
	PlayerManager.player.max_stamina = 5
	
	
	#combat skills
	PlayerManager.player.archery = 2
	PlayerManager.player.twoWeap = 1
	PlayerManager.player.greatWeap = 0
	PlayerManager.player.oneHand = 0
	PlayerManager.player.thrown = 0
	PlayerManager.player.martialArts = 0
	PlayerManager.player.lightArmor = 0
	PlayerManager.player.medArmor = 0
	PlayerManager.player.hevArmor = 0
	PlayerManager.player.evasion = 0
	
	#Magick Skills
	PlayerManager.player.creo = 1
	PlayerManager.player.intelligo = 0
	PlayerManager.player.muto = 1
	PlayerManager.player.perdo = 0
	PlayerManager.player.rego = 0
	PlayerManager.player.magicka = 1
	
	PlayerManager.player.animal = true
	PlayerManager.player.aquam = false
	PlayerManager.player.auram = false
	PlayerManager.player.corpus = false
	PlayerManager.player.herbam = true
	PlayerManager.player.ignem = false
	PlayerManager.player.imaginem = false
	PlayerManager.player.mentem = false
	PlayerManager.player.terram = false
	
	#survival skills
	PlayerManager.player.athletics = 1
	PlayerManager.player.deception = 0
	PlayerManager.player.history = 0
	PlayerManager.player.insight = 0
	PlayerManager.player.intimidation = 0
	PlayerManager.player.investigation = 0
	PlayerManager.player.knowledge = 0
	PlayerManager.player.firstaid = 0
	PlayerManager.player.nature = 2
	PlayerManager.player.perception = 0
	PlayerManager.player.performance = 0
	PlayerManager.player.religion = 0
	PlayerManager.player.ride = 0
	PlayerManager.player.stealth = 1
	PlayerManager.player.survival = 2
	PlayerManager.player.thievery = 0
	
	#crafting
	PlayerManager.player.mining = 0
	PlayerManager.player.logging = 1
	PlayerManager.player.cooking = 0
	PlayerManager.player.fishing = 0
	PlayerManager.player.blacksmithing = 0
	PlayerManager.player.weaponsmithing = 0
	PlayerManager.player.armorsmithing = 0
	PlayerManager.player.enchanting = 0
	PlayerManager.player.alchemy = 0
	PlayerManager.player.leatherworking = 1
	PlayerManager.player.woodworking = 2
	
func set_fighter_skills()->void:
	PlayerManager.player.might = 3
	PlayerManager.player.agility = 1
	PlayerManager.player.endurance = 2
	PlayerManager.player.intelligence = 2
	PlayerManager.player.cunning = 2
	PlayerManager.player.willpower = 1
	PlayerManager.player.charisma = 1
	PlayerManager.player.influence = 1
	PlayerManager.player.appearance = 1
	
	PlayerManager.player.max_hp = 5
	PlayerManager.player.max_mana = 5
	PlayerManager.player.max_stamina = 5
	
	
	#combat skills
	PlayerManager.player.archery = 0
	PlayerManager.player.twoWeap = 0
	PlayerManager.player.greatWeap = 1
	PlayerManager.player.oneHand = 2
	PlayerManager.player.thrown = 0
	PlayerManager.player.martialArts = 0
	PlayerManager.player.lightArmor = 0
	PlayerManager.player.medArmor = 0
	PlayerManager.player.hevArmor = 2
	PlayerManager.player.evasion = 0
	
	#Magick Skills
	PlayerManager.player.creo = 0
	PlayerManager.player.intelligo = 0
	PlayerManager.player.muto = 0
	PlayerManager.player.perdo = 0
	PlayerManager.player.rego = 0
	PlayerManager.player.magicka = 0
	
	PlayerManager.player.animal = false
	PlayerManager.player.aquam = false
	PlayerManager.player.auram = false
	PlayerManager.player.corpus = false
	PlayerManager.player.herbam = false
	PlayerManager.player.ignem = false
	PlayerManager.player.imaginem = false
	PlayerManager.player.mentem = false
	PlayerManager.player.terram = false
	
	#survival skills
	PlayerManager.player.athletics = 2
	PlayerManager.player.deception = 0
	PlayerManager.player.history = 0
	PlayerManager.player.insight = 0
	PlayerManager.player.intimidation = 2
	PlayerManager.player.investigation = 0
	PlayerManager.player.knowledge = 0
	PlayerManager.player.firstaid = 1
	PlayerManager.player.nature = 0
	PlayerManager.player.perception = 0
	PlayerManager.player.performance = 0
	PlayerManager.player.religion = 0
	PlayerManager.player.ride = 2
	PlayerManager.player.stealth = 0
	PlayerManager.player.survival = 0
	PlayerManager.player.thievery = 0
	
	#crafting
	PlayerManager.player.mining = 1
	PlayerManager.player.logging = 0
	PlayerManager.player.cooking = 0
	PlayerManager.player.fishing = 0
	PlayerManager.player.blacksmithing = 0
	PlayerManager.player.weaponsmithing = 2
	PlayerManager.player.armorsmithing = 2
	PlayerManager.player.enchanting = 0
	PlayerManager.player.alchemy = 0
	PlayerManager.player.leatherworking = 0
	PlayerManager.player.woodworking = 0
